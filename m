Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 01:14:13 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-Id: <20051213011413.1288f4cf.akpm@osdl.org>
In-Reply-To: <20051213090331.GB27857@infradead.org>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	<20051212161944.3185a3f9.akpm@osdl.org>
	<20051213075441.GB6765@elte.hu>
	<20051213075835.GZ15804@wotan.suse.de>
	<20051213004257.0f87d814.akpm@osdl.org>
	<20051213090331.GB27857@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: ak@suse.de, mingo@elte.hu, dhowells@redhat.com, torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Dec 13, 2005 at 12:42:57AM -0800, Andrew Morton wrote:
> > scsi/sd.c is currently getting an ICE.  None of the new SAS code compiles,
> > due to extensive use of anonymous unions.
> 
> This is just the headers in the luben code which need redoing completely
> because they're doing other stupid things like using bitfields for on the
> wire structures.

Don't think so (you're referring to Jeff's git-sas-jg.patch?).  It dies
with current -linus tree.


drivers/scsi/sd.c: In function `sd_read_capacity':
drivers/scsi/sd.c:1301: internal error--unrecognizable insn:
(insn 1274 1273 1797 (parallel[ 
            (set (reg:SI 0 %eax)
                (asm_operands ("") ("=a") 0[ 
                        (reg:DI 1 %edx)
                    ] 
                    [ 
                        (asm_input:DI ("A"))
                    ]  ("drivers/scsi/sd.c") 1282))
            (set (reg:SI 1 %edx)
                (asm_operands ("") ("=d") 1[ 
                        (reg:DI 1 %edx)
                    ] 
                    [ 
                        (asm_input:DI ("A"))
                    ]  ("drivers/scsi/sd.c") 1282))
        ] ) -1 (insn_list 1269 (nil))
    (nil))

It'll be workable aroundable of course, but it's a hassle.
