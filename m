From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/7] perf: New helper function for pmu name
Date: Mon, 11 Oct 2010 11:31:39 +0200
Message-ID: <1286789499.2336.206.camel@twins>
References: <cover.1286584677.git.matt@console-pimps.org>
	<a72a7968f5e3f64a26875457a7451b34f896f5ae.1286584677.git.matt@console-pimps.org>
	<20101011091809.GQ13563@erda.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20101011091809.GQ13563@erda.amd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Richter <robert.richter@amd.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Matt Fleming <matt@console-pimps.org>, Russell King <linux@arm.linux.org.uk>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Arnaldo Carvalho de Melo <acme@redhat.com>, Paul Mundt <lethal@linux-sh.org>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, Ingo Molnar <mingo@elte.hu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Mon, 2010-10-11 at 11:18 +0200, Robert Richter wrote:
> On 08.10.10 20:46:17, Matt Fleming wrote:
> > Introduce perf_pmu_name() helper function that returns the name of the
> > pmu. This gives us a generic way to get the name of a pmu regardless of
> > how an architecture identifies it internally.
> > 
> > Signed-off-by: Matt Fleming <matt@console-pimps.org>
> 
> Peter, I need your ack here.

Sure,

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
