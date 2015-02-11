From: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>
Subject: Re: [PATCH] compat: Fix endian issue in union sigval
Date: Wed, 11 Feb 2015 19:22:08 +0800
Message-ID: <54DB3B60.4050100@huawei.com>
References: <1423563011-12377-1-git-send-email-bamvor.zhangjian@huawei.com> <20150210122718.GC32052@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:11791 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbbBKLWb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Feb 2015 06:22:31 -0500
In-Reply-To: <20150210122718.GC32052@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "dingtianhong@huawei.com" <dingtianhong@huawei.com>, Will Deacon <Will.Deacon@arm.com>, "lizefan@huawei.com" <lizefan@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk

On 2015/2/10 20:27, Catalin Marinas wrote:
> cc'ing linux-arch as well.
> 
> On Tue, Feb 10, 2015 at 10:10:11AM +0000, Zhang Jian(Bamvor) wrote:
>> In 64bit architecture, sigval_int is the high 32bit of sigval_ptr in
>> big endian kernel compare with low 32bit of sigval_ptr in little
>> endian kernel. reference:
>>
>>     typedef union sigval {
>>         int sival_int;
>>         void *sival_ptr;
>>     } sigval_t;
>>
>> During compat_mq_notify or compat_timer_create, kernel get sigval
>> from user space by reading sigval.sival_int. This is correct in 32 bit
>> kernel and in 64bit little endian kernel. And It is wrong in 64bit big
>> endian kernel:
>> It get the high 32bit of sigval_ptr and put it to low 32bit of
>> sigval_ptr. And the high 32bit sigval_ptr in empty in arm 32bit user
>> space struct. So, kernel lost the value of sigval_ptr.
>>
>> The following patch get the sigval_ptr in stead of sigval_int in order
>> to avoid endian issue.
>> Test pass in arm64 big endian and little endian kernel.
>>
>> Signed-off-by: Zhang Jian(Bamvor) <bamvor.zhangjian@huawei.com>
>> ---
>>  ipc/compat_mq.c | 7 ++-----
>>  kernel/compat.c | 6 ++----
>>  2 files changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/ipc/compat_mq.c b/ipc/compat_mq.c
>> index ef6f91c..2e07343 100644
>> --- a/ipc/compat_mq.c
>> +++ b/ipc/compat_mq.c
>> @@ -99,11 +99,8 @@ COMPAT_SYSCALL_DEFINE2(mq_notify, mqd_t, mqdes,
>>  	if (u_notification) {
>>  		struct sigevent n;
>>  		p = compat_alloc_user_space(sizeof(*p));
>> -		if (get_compat_sigevent(&n, u_notification))
>> -			return -EFAULT;
>> -		if (n.sigev_notify == SIGEV_THREAD)
>> -			n.sigev_value.sival_ptr = compat_ptr(n.sigev_value.sival_int);
>> -		if (copy_to_user(p, &n, sizeof(*p)))
>> +		if (get_compat_sigevent(&n, u_notification) ||
>> +		    copy_to_user(p, &n, sizeof(*p)))
>>  			return -EFAULT;
> 
> The kernel doesn't need to interpret the sival_ptr value, it's something
> to be passed to the notifier function as an argument.
Yeah, this is the reason why I try to fix sival_ptr through
get_compat_sigevent before sys_mq_notify. After this compat wrapper,
sys_mq_notify will put the sival_ptr to nc buffer(file ipc/mqueue.c line 1221
to line 1226):
    if (copy_from_user(nc->data,
                    notification.sigev_value.sival_ptr,
                    NOTIFY_COOKIE_LEN)) {
            ret = -EFAULT;
            goto out;
    }
    /* TODO: add a header? */
    skb_put(nc, NOTIFY_COOKIE_LEN);
    /* and attach it to the socket */

The original changes is introduced by Alexander Viro
<viro@parcelfarce.linux.theplanet.co.uk> more than ten years ago[1]:

author   Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk> 2004-07-13 04:02:57 (GMT)
committer   Linus Torvalds <torvalds@ppc970.osdl.org>   2004-07-13 04:02:57 (GMT)
commit  95b5842264ac470a1a3a59d2741bb18adb140c8b (patch)
tree    5167f68fae8f3bbc9b3a2d7617d1500356837c16 /ipc/compat_mq.c
parent  de54add33621c5b4a1be895c82b7af96fb4dd447 (diff)
[PATCH] sparse: ipc compat annotations and cleanups
    ipc compat code switched to compat_alloc_user_space() and annotated.

> For the user's
> convenience, it is a union of an int and ptr. So I think the original
> SIGEV_THREAD check and compat_ptr() conversion here is wrong, it
> shouldn't exist at all (it doesn't exist in compat_sys_timer_create
> either). This hunk looks fine to me.
> 
>>  	}
>>  	return sys_mq_notify(mqdes, p);
>> diff --git a/kernel/compat.c b/kernel/compat.c
>> index ebb3c36..13a0e5d 100644
>> --- a/kernel/compat.c
>> +++ b/kernel/compat.c
>> @@ -871,16 +871,14 @@ COMPAT_SYSCALL_DEFINE4(clock_nanosleep, clockid_t, which_clock, int, flags,
>>   * We currently only need the following fields from the sigevent
>>   * structure: sigev_value, sigev_signo, sig_notify and (sometimes
>>   * sigev_notify_thread_id).  The others are handled in user mode.
>> - * We also assume that copying sigev_value.sival_int is sufficient
>> - * to keep all the bits of sigev_value.sival_ptr intact.
>>   */
>>  int get_compat_sigevent(struct sigevent *event,
>>  		const struct compat_sigevent __user *u_event)
>>  {
>>  	memset(event, 0, sizeof(*event));
>>  	return (!access_ok(VERIFY_READ, u_event, sizeof(*u_event)) ||
>> -		__get_user(event->sigev_value.sival_int,
>> -			&u_event->sigev_value.sival_int) ||
>> +		__get_user(*(long long*)event->sigev_value.sival_ptr,
should be:
		__get_user(event->sigev_value.sival_ptr,
> > +         &u_event->sigev_value.sival_ptr) ||
>
> I don't think this is correct because some (most) architectures use
> sival_int here when copying to user and for a big endian compat they
> would get 0 for sival_int (mips, powerpc).
Sorry, I am lost here. As we mentioned above, sival_ptr and sival_int
is union, so, copy sival_ptr should include sival_int.
>
> I think the correct fix is in the arm64 code:
The following code could fix my issue.

regards

bamvor

> diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
> index e299de396e9b..32601939a3c8 100644
> --- a/arch/arm64/kernel/signal32.c
> +++ b/arch/arm64/kernel/signal32.c
> @@ -154,8 +154,7 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
>  	case __SI_TIMER:
>  		 err |= __put_user(from->si_tid, &to->si_tid);
>  		 err |= __put_user(from->si_overrun, &to->si_overrun);
> -		 err |= __put_user((compat_uptr_t)(unsigned long)from->si_ptr,
> -				   &to->si_ptr);
> +		 err |= __put_user(from->si_int, &to->si_int);
>  		break;
>  	case __SI_POLL:
>  		err |= __put_user(from->si_band, &to->si_band);
> @@ -184,7 +183,7 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
>  	case __SI_MESGQ: /* But this is */
>  		err |= __put_user(from->si_pid, &to->si_pid);
>  		err |= __put_user(from->si_uid, &to->si_uid);
> -		err |= __put_user((compat_uptr_t)(unsigned long)from->si_ptr, &to->si_ptr);
> +		err |= __put_user(from->si_int, &to->si_int);
>  		break;
>  	case __SI_SYS:
>  		err |= __put_user((compat_uptr_t)(unsigned long)
> 
> But we need to check other architectures that are capable of big endian
> and have a compat layer.
> 
