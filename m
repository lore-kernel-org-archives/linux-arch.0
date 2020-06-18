Return-Path: <SRS0=SYs/=77=kvack.org=owner-linux-mm@kernel.org>
Date: Wed, 17 Jun 2020 18:12:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: Move p?d_alloc_track to separate header file
Message-ID: <20200617181226.ab213ea1531b5dd6eca1b0b6@linux-foundation.org>
In-Reply-To: <20200609120533.25867-1-joro@8bytes.org>
References: <20200609120533.25867-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
To: Joerg Roedel <joro@8bytes.org>
Cc: peterz@infradead.org, jroedel@suse.de, Andy Lutomirski <luto@kernel.org>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, manvanth@linux.vnet.ibm.com, linux-next@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Mike Rapoport <rppt@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, hch@lst.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200618011226.S6BBTHmjR3Aj-z6AnwK28EFIbrUz94i7UYu15HEEYHU@z>

On Tue,  9 Jun 2020 14:05:33 +0200 Joerg Roedel <joro@8bytes.org> wrote:

> From: Joerg Roedel <jroedel@suse.de>
> 
> The functions are only used in two source files, so there is no need
> for them to be in the global <linux/mm.h> header. Move them to the new
> <linux/pgalloc-track.h> header and include it only where needed.
> 
> ...
>
> new file mode 100644
> index 000000000000..1dcc865029a2
> --- /dev/null
> +++ b/include/linux/pgalloc-track.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PGALLLC_TRACK_H
> +#define _LINUX_PGALLLC_TRACK_H

hm, no #includes.  I guess this is OK, given the limited use.

But it does make one wonder whether ioremap.c should be moved from lib/
to mm/ and this file should be moved from include/linux/ to mm/.

Oh well.
