From: Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH 1/6][RFC] syscall: define syscall_get_arch() for each
	audit-supported arch
Date: Thu, 6 Mar 2014 14:55:10 -0500
Message-ID: <20140306195510.GA16640@madcap2.tricolour.ca>
References: <cover.1393974970.git.rgb@redhat.com>
	<cb88576237b1bc4fc7981200c2c23ae05790db0d.1393974970.git.rgb@redhat.com>
	<531833F0.8080300@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audit-bounces@redhat.com>
Content-Disposition: inline
In-Reply-To: <531833F0.8080300@imgtec.com>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-audit>,
	<mailto:linux-audit-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-audit>
List-Post: <mailto:linux-audit@redhat.com>
List-Help: <mailto:linux-audit-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-audit>,
	<mailto:linux-audit-request@redhat.com?subject=subscribe>
Sender: linux-audit-bounces@redhat.com
Errors-To: linux-audit-bounces@redhat.com
To: Markos Chandras <Markos.Chandras@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, oleg@redhat.com, linux-audit@redhat.com
List-Id: linux-arch.vger.kernel.org

On 14/03/06, Markos Chandras wrote:
> Hi Richard,

Hi Markos,

> On 03/05/2014 09:27 PM, Richard Guy Briggs wrote:
> >Each arch that supports audit requires syscall_get_arch() to able to log and
> >identify architecture-dependent syscall numbers.  The information is used in at
> >least two different subsystems, so standardize it in the same call across all
> >arches.
> >
> >Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> >
> >---
> >diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
> >index 81c8913..41ecde4 100644
> >--- a/arch/mips/include/asm/syscall.h
> >+++ b/arch/mips/include/asm/syscall.h
> >@@ -103,7 +103,7 @@ extern const unsigned long sysn32_call_table[];
> >
> >  static inline int __syscall_get_arch(void)
> >  {
> >-	int arch = EM_MIPS;
> >+	int arch = AUDIT_ARCH_MIPS;
> >  #ifdef CONFIG_64BIT
> >  	arch |=  __AUDIT_ARCH_64BIT;
> >  #endif
> >@@ -113,4 +113,10 @@ static inline int __syscall_get_arch(void)
> >  	return arch;
> >  }
> >
> >+static inline int syscall_get_arch(struct task_struct *task,
> >+				   struct pt_regs *regs)
> >+{
> >+	return __syscall_get_arch();
> >+}
> >+
> >  #endif	/* __ASM_MIPS_SYSCALL_H */
> 
> This is already fixed for MIPS
> 
> http://patchwork.linux-mips.org/patch/6398/
> 
> The code is in linux-next targeting 3.15 as far as I can tell.

Ok, good to see that it is pretty much the same approach.

My patchset is based on 3.13 (as I assume this patch is), so that
conflict will be sorted out once I add to linux-next...

> markos

- RGB

--
Richard Guy Briggs <rbriggs@redhat.com>
Senior Software Engineer, Kernel Security, AMER ENG Base Operating Systems, Red Hat
Remote, Ottawa, Canada
Voice: +1.647.777.2635, Internal: (81) 32635, Alt: +1.613.693.0684x3545
