From: Nicolas Pitre <nico@fluxnic.net>
Subject: =?GB2312?Q?Re=3A_=B4=F0=B8=B4=3A_A_bug_about_system_call_on_ARM?=
Date: Fri, 31 May 2013 00:03:35 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1305302356140.30828@syhkavp.arg>
References: <ih0015wu30o5nq4ajf437rl7.1369916575726@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <ih0015wu30o5nq4ajf437rl7.1369916575726@email.android.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: 'richard -rw- weinberger' <richard.weinberger@gmail.com>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 30 May 2013, Wang, Yalin wrote:

> Hi Will,
> 
> i see your solution,
> i Will test it tomorrow,
> and report the result to you ASAP!

This is good if you can report success without changing any of your 
current configuration.  This issue is worth fixing.

However, as others have mentioned already, you most likely can set 
CONFIG_OABI_COMPAT to n afterwards.  Not only will this make you immune 
to the bug you reported, but that will also make the syscall path more 
efficient as well.


Nicolas
