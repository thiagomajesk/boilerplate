/**
 * Inspiration taken from the way Livebook deals with hook props:
 * https://github.com/livebook-dev/livebook/blob/main/assets/js/lib/attribute.js
 */
import normalize from "normalize-object";

function extractProps(element, names) {
  return names.map((name) => {
    const attribute = `data-prop-${name}`;
    const message = `Missing attribute ${attribute} on element ${element.tagName}#${element.id}`;
    if (!element.hasAttribute(attribute)) throw new Error(message);
    return [name, JSON.parse(element.getAttribute(attribute))];
  });
}

/**
 * Parses hook properties from a DOM element based on the provided attribute names.
 *
 * @param {HTMLElement} element - The DOM element to parse attributes from.
 * @param {string[]} names - An array of attribute names to look for.
 * @throws {Error} Throws an error if a required attribute is missing.
 * @returns {Object} An object containing the parsed attributes as key-value pairs.
 */
export function parseHookProps(element, names) {
  const props = extractProps(element, names);
  return normalize(Object.fromEntries(props));
}
