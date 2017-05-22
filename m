From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [GIT PULL] ARM: SoC fixes (and a cross-arch dt-include fix)
Date: Mon, 22 May 2017 13:44:35 +0200
Message-ID: <CACRpkdaRdZTB39-=sAojO+OyHtP02KaFChqGcxy+fWA8qaB2bw@mail.gmail.com>
References: <20170519193455.GA24206@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170519193455.GA24206@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Fri, May 19, 2017 at 9:34 PM, Olof Johansson <olof@lixom.net> wrote:

>  - We've started telling people to avoid cross-tree shared branches if all
>    they're doing is picking up one or two DT-used constants from a
>    shared include file, and instead to use the numeric values on first
>    submission. Follow-up moving over to symbolic names are sent in right
>    after -rc1, i.e. here. It's only a few minor patches of this type.

OK it seems like a reasonable process.

It's not like I can think about anything better.

I was more opting for doing things this way:

- Create bindings and <dt-bindings/foo/bar.h> merge it into the
  foo subsystem.

- Merge driver into drivers/foo/bar.c that use <dt-bindings/foo/bar.h>

- Submit DTS patch to ARM SoC (or whetever) using only numerical
  values.

- After the merge window, follow up with a patch replacing the
  numerical constants with #defines from <dt-bindings/foo/bar.h>

An alternative would obviously be to wait for the next merge window
after merging the driver patch but I guess people are too impatient
to do that (including me).

We discussed cross-tree dependencies a bit on ksummit-discuss
but this solution was not mentioned back then.

Yours,
Linus Walleij
