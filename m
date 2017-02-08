From: Matthew Wilcox <willy@infradead.org>
Subject: Re: memfill
Date: Wed, 8 Feb 2017 13:54:35 -0800
Message-ID: <20170208215435.GP2267@bombadil.infradead.org>
References: <1486307804-27903-1-git-send-email-minchan@kernel.org>
 <20170206144902.GH2267@bombadil.infradead.org>
 <1486494454.2488.60.camel@HansenPartnership.com>
 <20170208180447.GO2267@bombadil.infradead.org>
 <1486587668.2484.37.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1486587668.2484.37.camel@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sergey.senozhatsky@gmail.com, iamjoonsoo.kim@lge.com, ngupta@vflare.org, zhouxianrong@huawei.com, zhouxiyu@huawei.com, weidu.du@huawei.com, zhangshiming5@huawei.com, Mi.Sophia.Wang@huawei.com, won.ho.park@huawei.com, liw@liw.fi
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 08, 2017 at 01:01:08PM -0800, James Bottomley wrote:
> Yes, that's about it.  My only qualm looking at the proposal was if
> memfill is genuinely useful to something why would it only want to fill
> in units of sizeof(long).  On the other hand, we've been operating for
> decades without it, so perhaps memset_l is the only use case?

I suspect we've grown hundreds of unoptimised implementations of this all
over the kernel.  I mean, look at the attitude of the zram developers when
I suggested memfill: "this is beyond zram scope."  I think finding all of
these is beyond the abilities of grep.  maybe coccinelle could find some?

Instead I chose a driver at random that both you and I are familiar with,
sym53c8xx_2.  Oh, look, here's one:

        np->badlun_sa = cpu_to_scr(SCRIPTB_BA(np, resel_bad_lun));
        for (i = 0 ; i < 64 ; i++)      /* 64 luns/target, no less */
                np->badluntbl[i] = cpu_to_scr(vtobus(&np->badlun_sa));

and another one:

                for (i = 0 ; i < 64 ; i++)
                        tp->luntbl[i] = cpu_to_scr(vtobus(&np->badlun_sa));

and another:

        for (i = 0 ; i < SYM_CONF_MAX_TASK ; i++)
                lp->itlq_tbl[i] = cpu_to_scr(np->notask_ba);

I don't think any of these are performance path, but they're there.

Maybe SCSI drivers are unusual.  Let's try a random network driver, e1000e:

        /* Clear shadow ram */
        for (i = 0; i < nvm->word_size; i++) {
                dev_spec->shadow_ram[i].modified = false;
                dev_spec->shadow_ram[i].value = 0xFFFF;
        }

(three of those loops)

I mean, it's not going to bring the house down, but that I chose two
drivers more or less at random and found places where such an API could
be used indicates there may be more places this should be used.  And it
gives architectures a good place to plug in a performance optimisation
for zram rather than hiding it away in that funny old driver almost
nobody looks at.
