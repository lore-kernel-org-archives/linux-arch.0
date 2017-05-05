From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH 0/3] arm64: queued
 spinlocks and rw-locks
Date: Fri, 5 May 2017 13:53:03 +0200
Message-ID: <20170505115303.s3bsu4adfgkxrhh2@hirez.programming.kicks-ass.net>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com>
 <SIXPR0199MB0604CF9C101455F7D7417FF7C5160@SIXPR0199MB0604.apcprd01.prod.exchangelabs.com>
 <20170504202809.lv222a3oes54ijkj@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170504202809.lv222a3oes54ijkj@yury-N73SV>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andrew Pinski <Andrew.Pinski@cavium.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Adam Wallis <awallis@codeaurora.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Jan Glauber <jglauber@cavium.com>, pan xinhui <mnipxh@hotmail.com>, Mark Rutland <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thu, May 04, 2017 at 11:28:09PM +0300, Yury Norov wrote:
> I don't think
> it's a real use case to have ticket spinlocks and queued rwlocks

There's nothing wrong with that combination. In fact, we merged qrwlock
much earlier than qspinlock.
