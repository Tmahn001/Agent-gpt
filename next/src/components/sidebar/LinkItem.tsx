import type { ReactNode } from "react";
import clsx from "clsx";
import Badge from "../Badge";

const LinkItem = (props: {
  title: string;
  children: ReactNode;
  href?: string;
  badge?: string;
  onClick: () => void;
}) => (
  <li>
    <a
      href={props.href}
      className={clsx(
        "text-color-secondary hover:background-color-10 hover:text-color-primary cursor-pointer",
        "group flex gap-x-3 rounded-md px-2 py-1 text-sm font-semibold leading-7"
      )}
      onClick={(e) => {
        e.preventDefault();
        props.onClick();
      }}
    >
      <span className="text-color-secondary group-hover:text-color-primary  flex h-[2em] w-[2em] shrink-0 items-center justify-center rounded-lg border text-sm font-medium group-hover:scale-110">
        {props.children}
      </span>
      <span>{props.title}</span>
      {props.badge && <Badge className="ml-auto bg-gradient-to-r from-[#5076F6] to-[#0b3769e4]">{props.badge}</Badge>}
    </a>
  </li>
);

export default LinkItem;
