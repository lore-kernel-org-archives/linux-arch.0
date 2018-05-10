From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 5/8] export.h: remove code for prefixing symbols with
 underscore
Date: Thu, 10 May 2018 07:08:03 +0200
Message-ID: <20180510050803.GA19160@ravnborg.org>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
 <1525850632-10921-6-git-send-email-yamada.masahiro@socionext.com>
 <20180509160727.GA7459@ravnborg.org>
 <CAK7LNATojTR5QbWNS2LCeRXTX-8Rj3P2VoZaYZQhY5Kb0fv1Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNATojTR5QbWNS2LCeRXTX-8Rj3P2VoZaYZQhY5Kb0fv1Mg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Mashahiro

> Anyway VMLINUX_SYMBOL(), VMLINUX_SYMBOL_STR() will not live long.
> I need some cycles for tree-wide cleaning, though.

Fine, then there is no need to discuss the details of their
current definition.

	Sam
