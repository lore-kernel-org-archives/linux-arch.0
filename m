From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 12/22] lmb: Add lmb_find_area_node()
Date: Mon, 10 May 2010 16:23:16 +1000
Message-ID: <1273472596.23699.37.camel@pasglop>
References: <1273331860-14325-1-git-send-email-yinghai@kernel.org>
	 <1273331860-14325-13-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1273331860-14325-13-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, 2010-05-08 at 08:17 -0700, Yinghai Lu wrote:
> + * Need to call this function after lmb_register_active_regions,
> + * so early_node_map[] is filled already.
> + */

This is easily replaced by something simpler using my current WIP branch
and its nid allocator. IE, You don't need to add
find_memory_core_early(0 or any of that. It can be made a lot more
simply.

Cheers,
Ben.

> +u64 __init lmb_find_area_node(int nid, u64 start, u64 end, u64 size,
> u64 align)
> +{
> +       u64 addr;
> +       addr = find_memory_core_early(nid, size, align, start, end);
> +       if (addr != LMB_ERROR)
> +               return addr;
> +
> +       /* Fallback, should already have start end within node range
> */
> +       return lmb_find_area(start, end, size, align);
> +}
> + 
