Return-Path: <linux-arch-owner@vger.kernel.org>
Received: by zproxy.gmail.com with SMTP id 34so1674473nzf
        for <linux-arch@vger.kernel.org>; Tue, 13 Dec 2005 02:16:12 -0800 (PST)
Date: Tue, 13 Dec 2005 13:31:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: drivers/scsi/sd.c gcc-2.95.3
Message-ID: <20051213103135.GA19500@mipter.zuzino.mipt.ru>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213090331.GB27857@infradead.org> <20051213011413.1288f4cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213011413.1288f4cf.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, ak@suse.de, mingo@elte.hu, dhowells@redhat.com, torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Dec 13, 2005 at 01:14:13AM -0800, Andrew Morton wrote:
> drivers/scsi/sd.c: In function `sd_read_capacity':
> drivers/scsi/sd.c:1301: internal error--unrecognizable insn:
> (insn 1274 1273 1797 (parallel[ 
>             (set (reg:SI 0 %eax)
>                 (asm_operands ("") ("=a") 0[ 
>                         (reg:DI 1 %edx)
>                     ] 
>                     [ 
>                         (asm_input:DI ("A"))
>                     ]  ("drivers/scsi/sd.c") 1282))
>             (set (reg:SI 1 %edx)
>                 (asm_operands ("") ("=d") 1[ 
>                         (reg:DI 1 %edx)
>                     ] 
>                     [ 
>                         (asm_input:DI ("A"))
>                     ]  ("drivers/scsi/sd.c") 1282))
>         ] ) -1 (insn_list 1269 (nil))
>     (nil))
> 
> It'll be workable aroundable of course, but it's a hassle.

FWIW,

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1282,9 +1282,9 @@ got_data:
 		sector_div(mb, 1950);
 
 		printk(KERN_NOTICE "SCSI device %s: "
-		       "%llu %d-byte hdwr sectors (%llu MB)\n",
+		       "%llu %d-byte hdwr sectors\n",
 		       diskname, (unsigned long long)sdkp->capacity,
-		       hard_sector, (unsigned long long)mb);
+		       hard_sector);
 	}
 
 	/* Rescale capacity to 512-byte units */
