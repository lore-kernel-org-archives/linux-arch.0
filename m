From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v2 00/29] nios2 Linux kernel port
Date: Wed, 16 Jul 2014 09:21:18 +0800
Message-ID: <CAFiDJ59f0p3MF=ffH-Qk8Xx3w=sC-XqVMgeHKiQzcQ1=P=X+Xw@mail.gmail.com>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
	<20140715090813.GE7668@distanz.ch>
	<CAFiDJ5-YNB_uctBYFGkoABHfnwhuncy2FGrQk1j0qPVZBDrC3g@mail.gmail.com>
	<20140715111541.GG7668@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140715111541.GG7668@distanz.ch>
Sender: linux-doc-owner@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 15, 2014 at 7:15 PM, Tobias Klauser <tklauser@distanz.ch> wrote:
> Hi Ley Foon

>
> Ah, thanks for the notice. Is it still possible to use the old syscall
> ABI as a replacement on top of this series and use the current toolchain
> from Mentor Graphics?
Hi Tobias

There are other changes in the nios2 kernel that requires new compiler.
So, old syscall ABI replacement most probably won't work.

Regards
Ley Foon
