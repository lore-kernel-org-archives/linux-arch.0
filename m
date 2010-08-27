From: Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH V2 3/4] oprofile: Abstract the perf-events backend
Date: Fri, 27 Aug 2010 14:59:56 +0200
Message-ID: <20100827125956.GK22783@erda.amd.com>
References: <cover.1282848651.git.matt@console-pimps.org>
 <fe3e173aaa85f4cd73ea4b5abca50976fc40a01f.1282848651.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fe3e173aaa85f4cd73ea4b5abca50976fc40a01f.1282848651.git.matt@console-pimps.org>
Sender: linux-sh-owner@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 26.08.10 15:09:18, Matt Fleming wrote:
> Move the perf-events backend from arch/arm/oprofile into
> drivers/oprofile so that the code can be shared between architectures.
> 
> This allows each architecture to maintain only a single copy of the
> PMU accessor functions instead of one for both perf and OProfile. It
> also becomes possible for other architectures to delete much of their
> OProfile code in favour of the common code now available in
> drivers/oprofile/oprofile_perf.c.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> ---
>  arch/arm/oprofile/Makefile       |    4 +
>  arch/arm/oprofile/common.c       |  215 +++-----------------------------------
>  drivers/oprofile/oprofile_perf.c |  209 ++++++++++++++++++++++++++++++++++++
>  include/linux/oprofile.h         |   12 ++
>  4 files changed, 242 insertions(+), 198 deletions(-)
>  create mode 100644 drivers/oprofile/oprofile_perf.c

Could we split this patch in 2 for better review? One that only moves
the code and a 2nd that changes it.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center

