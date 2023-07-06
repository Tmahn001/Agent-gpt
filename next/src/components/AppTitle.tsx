import PopIn from "./motions/popin";
import Badge from "./Badge";
import React from "react";
import { useTranslation } from "next-i18next";

const AppTitle = () => {
  const { i18n } = useTranslation();

  return (
    <div id="title" className="relative flex flex-col items-center font-mono">
      <div className="flex flex-row items-start">
        <span className="text-3xl font-bold text-[#C0C0C0] xs:text-4xl sm:text-5xl">FGTAgent</span>
        <span className="text-3xl font-bold text-white xs:text-4xl sm:text-5xl">GPT</span>
        <PopIn delay={0.5}>
          <Badge colorClass="bg-gradient-to-t from-[#5076F6] to-sky-400 border-2 border-white/20">
            {i18n?.t("BETA", {
              ns: "indexPage",
            })}
            &nbsp;🚀
          </Badge>
        </PopIn>
      </div>
      <div className="mt-1 text-center font-mono text-[0.7em] font-bold text-white">
        <p>
          {i18n.t("HEADING_DESCRIPTION", {
            ns: "indexPage",
          })}
        </p>
      </div>
    </div>
  );
};

export default AppTitle;
