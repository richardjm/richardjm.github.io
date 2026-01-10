import React from 'react';
import PropTypes from 'prop-types';

export default function Thumbnail({ src, alt, link, width = 150, style = {}, ...props }) {
  const img = (
    <img
      src={src}
      alt={alt}
      style={{ width, verticalAlign: 'top', padding: '5px', ...style }}
      {...props}
    />
  );
  return link ? (
    <a href={link} style={{ display: 'inline-block' }}>{img}</a>
  ) : (
    img
  );
}

Thumbnail.propTypes = {
  src: PropTypes.string.isRequired,
  alt: PropTypes.string,
  link: PropTypes.string,
  width: PropTypes.oneOfType([PropTypes.string, PropTypes.number]),
  style: PropTypes.object,
};
