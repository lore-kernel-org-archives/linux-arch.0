From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v11 00/33] use lmb with x86
Date: Tue, 30 Mar 2010 19:16:45 -0700
Message-ID: <1270001838-15857-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

the new lmb could be used to early_res in x86.

Suggested by: David, Ben, and Thomas

First one should go into 2.6.34.

-v6: change sequence as requested by Thomas
-v7: seperate them to more patches
-v8: add boundary checking to make sure not free partial page.
-v9: use lmb_debug to control print out of reserve_lmb.
     add e820 clean up, and e820 become __initdata
-v10:use lmb.rmo_size and ARCH_DISCARD_LMB according to Michael
     change name to lmb_find_area/reserve_lmb_area/free_lmb_area,
      according to Michael
     update find_lmb_area to use __lmb_alloc_base according to ben
-v11:move find_lmb_area_size back to x86.
     x86 has own find_lmb_area, and could be disabled by ARCH_LMB_FIND_AREA
      because _lmb_find_base has different behavoir from x86's old one.
      one from high to high and one from low to high
      need more test
     tested for x86 32bit/64bit, numa/nonuma, nobootmem/bootmem.

still keep find_lmb_area, may replace those find_lmb_area will lmb_alloc, if
everything go fine

Please consider to put them into tip to have more test coverage.

Thanks

Yinghai
