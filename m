From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/28] nios2 Linux kernel port
Date: Sat, 19 Apr 2014 17:30:54 +0200
Message-ID: <201404191730.54400.arnd@arndb.de>
References: <1397824031-4892-1-git-send-email-lftan@altera.com> <53518FAC.8020504@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <53518FAC.8020504@zytor.com>
Sender: linux-doc-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Friday 18 April 2014, H. Peter Anvin wrote:
> On 04/18/2014 05:26 AM, Ley Foon Tan wrote:
> > This patchset adds the Linux kernel port for Nios II processor from Altera.
> > The nios2 Linux port follows the guidance for new architecture ports using
> > generic headers (including unistd.h).
> 
> Did the generic headers ever get updated to match Linus' guidance that
> any new architecture ports should use a 64-bit time_t?

No, unfortunately not. With my rule that every architecture that gets
added needs to clean up asm-generic some more, to make it easier to add
the next one, we should probably do for nios2.

	Arnd
