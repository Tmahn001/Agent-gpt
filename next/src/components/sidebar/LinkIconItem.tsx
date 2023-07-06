import type { ReactNode } from "react";
import clsx from "clsx";

const LinkIconItem = (props: { children: ReactNode; href?: string; onClick: () => void }) => (
  <a
    href={props.href}
    className={clsx(
      "grid h-10 w-10  cursor-pointer place-items-center rounded-xl text-2xl bg-[#5076F6]",
      "text-[#fff] ",
      "group group-hover:scale-110"
    )}
    onClick={(e) => {
      e.preventDefault();
      props.onClick();
    }}
  >
    {props.children}
  </a>
);

export default LinkIconItem;
