From: Alex Belits <abelits@marvell.com>
Subject: Re: [EXT] Re: [PATCH v2 03/12] task_isolation: userspace hard
 isolation from kernel
Date: Sun, 8 Mar 2020 07:33:26 +0000
Message-ID: <f0b4a621cf3b49d649ea0b23d93721cf7ca24d6e.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
 <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
 <105f17f25e90a9a58299a7ed644bdd0f36434c87.camel@marvell.com>
 <20200307214254.7a8f6c22@hermes.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200307214254.7a8f6c22@hermes.lan>
Content-Language: en-US
Content-ID: <964184D5A0236941AA1717025730F649@namprd18.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: "stephen@networkplumber.org" <stephen@networkplumber.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, Prasun Kapoor <pkapoor@marvell.com>, "frederic@kernel.org" <frederic@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "will@kernel.org" <will@kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Sat, 2020-03-07 at 21:42 -0800, Stephen Hemminger wrote:
> On Sun, 8 Mar 2020 03:47:08 +0000
> Alex Belits <abelits@marvell.com> wrote:
> 
> > +int task_isolation_message(int cpu, int level, bool supp, const
> > char *fmt, ...);
> 
> Since you are doing printf/printk var args you should use the GCC
> format attributes
> like printk.

Agreed.

-- 
Alex
