From: Peter Zijlstra <peterz@infradead.org>
Subject: Re:  [PATCH 00/20] mm: Preemptibility -v4
Date: Tue, 14 Sep 2010 09:42:48 +0200
Message-ID: <1284450168.2275.452.camel@laptop>
References: <20100828141637.421594670@chello.nl>
	 <AANLkTikSm2Mq8hGNac9rpFH-3pvryw2kW57EP45Ny6Vp@mail.gmail.com>
	 <1284442585.26157.8150.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1284442585.26157.8150.camel@debian>
Sender: linux-kernel-owner@vger.kernel.org
To: "Alex,Shi" <alex.shi@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Chen, Tim C" <tim.c.chen@intel.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 2010-09-14 at 13:36 +0800, Alex,Shi wrote:
> Peter:
> We tested your tree base on 2.6.36-rc3 kernel. The testing covered on
> Core2 2P, NHM-EP/WSM-EP machines, no clear performance regression found
> on your patch compare to 36-rc3, and also no clear improvements on our
> benchmarks. 
> 
> The benchmarks are listed in the following website, and plus some of
> FFSB/FIO scenarios.  http://kernel-perf.sourceforge.net/ 

Thanks, much appreciated!!

Hopefully we'll get sparc64 fixed up soon and can talk about merging
this.
