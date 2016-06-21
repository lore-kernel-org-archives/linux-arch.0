From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/19] arm64: introduce is_a32_task and is_a32_thread (for
 AArch32 compat)
Date: Tue, 21 Jun 2016 17:47:44 +0200
Message-ID: <4650742.YG7pOR48ul@wuerfel>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
 <576915B0.5040706@huawei.com> <mvmk2hipyfw.fsf@hawking.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <mvmk2hipyfw.fsf@hawking.suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: libc-alpha@sourceware.org
Cc: linux-doc@vger.kernel.org, szabolcs.nagy@arm.com, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, Yury Norov <ynorov@caviumnetworks.com>, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, linux-arch@vger.kernel.org, Prasun.Kapoor@caviumnetworks.com, Andreas Schwab <schwab@suse.de>, agraf@suse.de, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

On Tuesday, June 21, 2016 1:34:59 PM CEST Andreas Schwab wrote:
> "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com> writes:
> 
> >> @@ -78,9 +79,9 @@
> >>
> >>   #ifdef CONFIG_COMPAT
> >>   #define TASK_SIZE_32               UL(0x100000000)
> >> -#define TASK_SIZE           (test_thread_flag(TIF_32BIT) ? \
> >> +#define TASK_SIZE           (is_compat_task() ?             \
> >>                              TASK_SIZE_32 : TASK_SIZE_64)
> >> -#define TASK_SIZE_OF(tsk)   (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
> >> +#define TASK_SIZE_OF(tsk)   (is_compat_thread(tsk) ? \
> > It should be
> > +#define TASK_SIZE_OF(tsk)      (is_compat_thread(task_thread_info(tsk)) ? \
> > is_compat_thread takes "struct thread_info *thread" while TASK_SIZE_OF takes
> > "struct task_struct *tsk"tsk.
> 
> If that doesn't throw an error does that mean that TASK_SIZE_OF is
> unused?

I think that is correct. On some architectures, TASK_SIZE (which is used)
is defined as TASK_SIZE_OF(current), but the definition above doesn't
do that and there are no other users.

	Arnd
