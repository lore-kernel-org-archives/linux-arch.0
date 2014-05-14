From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 12/27] m32r: Use generic tlb.h
Date: Wed, 14 May 2014 15:05:56 -0400
Message-ID: <5373BE94.1060800@redhat.com>
References: <1400093999-18703-1-git-send-email-richard@nod.at> <1400093999-18703-13-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400093999-18703-13-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Hirokazu Takata <takata@linux-m32r.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, Frederic Weisbecker <fweisbec@gmail.com>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org
List-Id: linux-arch.vger.kernel.org

On 05/14/2014 02:59 PM, Richard Weinberger wrote:
> As everything we need is now in generic tlb.h
> we can drop our own one.
> 
> Cc: Hirokazu Takata <takata@linux-m32r.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-m32r@ml.linux-m32r.org
> Cc: linux-m32r-ja@ml.linux-m32r.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Richard Weinberger <richard@nod.at>

Acked-by: Rik van Riel <riel@redhat.com>

-- 
All rights reversed
