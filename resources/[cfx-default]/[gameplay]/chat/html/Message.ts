/*
 ______ _           __  __      _ _    
|  ____(_)         |  \/  |    | | |   
| |__   ___   _____| \  / |  __| | | __
|  __| | \ \ / / _ \ |\/| | / _` | |/ /
| |    | |\ V /  __/ |  | || (_| |   < 
|_|    |_| \_/ \___|_|  |_(_)__,_|_|\_\

Vores sider:
  • Hjemmesiden: https://fivem.dk
  • Patreon: https://patreon.com/dkfivem
  • Facebook: https://facebook.com/dkfivem
  • Discord: https://discord.gg/dkfivem
  • DybHosting: https://dybhosting.eu/ - Rabatkode: dkfivem10
*/

import CONFIG from './config';
import Vue, { PropType } from 'vue';

export default Vue.component('message', {
  data() {
    return {};
  },
  computed: {
    textEscaped(): string {
      let s = this.template ? this.template : this.templates[this.templateId];

      //This hack is required to preserve backwards compatability
      if (!this.template && this.templateId == CONFIG.defaultTemplateId
          && this.args.length == 1) {
        s = this.templates[CONFIG.defaultAltTemplateId] //Swap out default template :/
      }

      s = s.replace(`@default`, this.templates[this.templateId]);

      s = s.replace(/{(\d+)}/g, (match, number) => {
        const argEscaped = this.args[number] != undefined ? this.escape(this.args[number]) : match;
        if (number == 0 && this.color) {
          //color is deprecated, use templates or ^1 etc.
          return this.colorizeOld(argEscaped);
        }
        return argEscaped;
      });

      // format variant args
      s = s.replace(/\{\{([a-zA-Z0-9_\-]+?)\}\}/g, (match, id) => {
        const argEscaped = this.params[id] != undefined ? this.escape(this.params[id]) : match;
        return argEscaped;
      });

      return this.colorize(s);
    },
  },
  methods: {
    colorizeOld(str: string): string {
      return `<span style="color: rgb(${this.color[0]}, ${this.color[1]}, ${this.color[2]})">${str}</span>`
    },
    colorize(str: string): string {
      let s = "<span>" + colorTrans(str) + "</span>";

      const styleDict: {[ key: string ]: string} = {
        '*': 'font-weight: bold;',
        '_': 'text-decoration: underline;',
        '~': 'text-decoration: line-through;',
        '=': 'text-decoration: underline line-through;',
        'r': 'text-decoration: none;font-weight: normal;',
      };

      const styleRegex = /\^(\_|\*|\=|\~|\/|r)(.*?)(?=$|\^r|<\/em>)/;
      while (s.match(styleRegex)) { //Any better solution would be appreciated :P
        s = s.replace(styleRegex, (str, style, inner) => `<em style="${styleDict[style]}">${inner}</em>`)
      }
      return s.replace(/<span[^>]*><\/span[^>]*>/g, '');

      function colorTrans(str: string) {
        return str
          .replace(/\^([0-9])/g, (str, color) => `</span><span class="color-${color}">`)
          .replace(/\^#([0-9A-F]{3,6})/gi, (str, color) => `</span><span class="color" style="color: #${color}">`)
          .replace(/~([a-z])~/g, (str, color) => `</span><span class="gameColor-${color}">`);
      }
    },
    escape(unsafe: string): string {
      return String(unsafe)
       .replace(/&/g, '&amp;')
       .replace(/</g, '&lt;')
       .replace(/>/g, '&gt;')
       .replace(/"/g, '&quot;')
       .replace(/'/g, '&#039;');
    },
  },
  props: {
    templates: {
      type: Object as PropType<{ [key: string]: string }>,
    },
    args: {
      type: Array as PropType<string[]>,
    },
    params: {
      type: Object as PropType<{ [ key: string]: string }>,
    },
    template: {
      type: String,
      default: null,
    },
    templateId: {
      type: String,
      default: CONFIG.defaultTemplateId,
    },
    multiline: {
      type: Boolean,
      default: false,
    },
    color: { //deprecated
      type: Array as PropType<number[]>,
      default: null,
    },
  },
});
