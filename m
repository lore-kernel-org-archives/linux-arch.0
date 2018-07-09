From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Date: Mon, 9 Jul 2018 17:34:27 +0200
Message-ID: <20180709153427.GY2476@hirez.programming.kicks-ass.net>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
 <20180709140717.GR2476@hirez.programming.kicks-ass.net>
 <20180709141056.GR2512@hirez.programming.kicks-ass.net>
 <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
 <20180709144925.GU2476@hirez.programming.kicks-ass.net>
 <20180709152958.565weccfaktqauef@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180709152958.565weccfaktqauef@lakrids.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 09, 2018 at 04:29:58PM +0100, Mark Rutland wrote:
> Shouldn't that be 8? AFAICT, __alignof__(unsigned long long) is 8 on
> x86_32:

Curious, I wonder why we put that align in atomic64_32 then.
