From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/28] nios2: Exception handling
Date: Wed, 23 Apr 2014 14:23:50 +0200
Message-ID: <201404231423.51221.arnd@arndb.de>
References: <1397824031-4892-1-git-send-email-lftan@altera.com> <CAFiDJ58oeUtXR_gqud9pw55wojY6PJRQp8PAyEfpDL_Let7u=Q@mail.gmail.com> <CAMuHMdX1xxuWhhBH0TKMtSEek5QDYchNVtC9QKoFQGr454_GVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.131]:51761 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbaDWMYH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Apr 2014 08:24:07 -0400
In-Reply-To: <CAMuHMdX1xxuWhhBH0TKMtSEek5QDYchNVtC9QKoFQGr454_GVA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ley Foon Tan <lftan@altera.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com

On Wednesday 23 April 2014, Geert Uytterhoeven wrote:
> On Wed, Apr 23, 2014 at 4:47 AM, Ley Foon Tan <lftan@altera.com> wrote:
> > On Tue, Apr 22, 2014 at 8:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Friday 18 April 2014, Ley Foon Tan wrote:
> >>> +static const struct file_operations misalign_fops = {
> >>> +       .open           = proc_misaligned_open,
> >>> +       .read           = seq_read,
> >>> +       .llseek         = seq_lseek,
> >>> +       .release        = single_release,
> >>> +       .write          = proc_misaligned_write,
> >>> +};
> >>> +#endif /* CONFIG_PROC_FS */
> >>
> >> We really shouldn't be doing new architecture specific procfs files
> >> any more. I suggest you drop this one for now, and add back the
> >> functionality using perf or ftrace at a later point.
> >
> > Okay, will remove this.
> 
> MIPS and powerpc handle this through debugfs, cfr.
> arch/mips/kernel/unaligned.c and arch/powerpc/kernel/traps.c.

Ah, right, that would work too. Being able to use perf from user
space sounds more flexible though. It's certainly something that
can be decided later.

	Arnd
