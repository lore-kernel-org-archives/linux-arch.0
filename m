From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date: Thu, 28 Jan 2016 19:00:30 +0100
Message-ID: <CAMuHMdWCwP8Hkn+tGEoG-FxUnjAq8uExcPhmXASh_ErU8DDN2w@mail.gmail.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
	<1947556.38OyJnvGS5@wuerfel>
	<20160127093018.GA21190@wfg-t540p.sh.intel.com>
	<3596300.IYfzmako0c@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <3596300.IYfzmako0c@wuerfel>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Fengguang Wu <fengguang.wu@intel.com>, James Hogan <james.hogan@imgtec.com>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Marek <mmarek@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On Wed, Jan 27, 2016 at 10:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> - in some configurations, you end up without any boards selected, hitting
>   an #error in the final link

FWIW, I have a similar problem with m68k+MMU=y randconfig...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
