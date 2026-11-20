Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180730;
	b=0F8uqpdwYNI9bfrv12qVnuOs92o0rpNwPq9LEDcdbstXLlOlIjSX4k65k0LuXp+b8jyl
	 Zrvdj9JQ9bz43JootPy+CysgT+vSjT4UUm81cA8pydUmRj9Jx7Srf0ThwIwlQ/Setx2bs
	 PmkrZNIwm7qLeXqYT0yn3P0enqV1vfoeB1xoJWW3Zzsi8U0eofJh13mtUXuOl8US3x25e
	 5nDqoImMoIkOdDtyp5Y/Mh9Y/8G8Tkeq4SFUTcNAxyvcVFq9sYFmMqk3+SKoX7pNIXqBJ
	 +cKHbAKbVTpptQ7AYk6KS0q2bsIQB7M7wBSYFCBTn6BXteClWPGhZ/GkLKu6wE2fPfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=YAQTVNIYZ/0Tbx2obltQhn42YTPBHmmwY733kBIibzM=;
	b=WfIulbTc2PSsmgvpaBqu1pJtacrClvjj02yFe29tN+ssX6FLlcAxaSWJth6DonmnI6oD
	 2kgEx3o++NcHABMqfPtv40PkrDcABlW0b8VHt9QIvE6cRMz3yoHtlXj4xXN8YEjzfG6gT
	 HLR+3kKJa9RjYR4jBAIrWtDTvu1tReks/IoAkBqU5Aopk9L+WZERkq16C+9dfE3MhT7HW
	 N8/19NCvDkM5YsQBHIrjAK9THWCP2TXXDSAEYHiCKdIQF6v2Y5LSKHuPWdhJF8XPyXQD6
	 u5i5Psf4NUsqw2qrFYAipDCnU6OAGxbVCr+skWRWAnmbc7uXKHQxmVMW7cG9iM+HD2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="UI/9rv+D";
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2D606A331
	for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2026 13:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28D2D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UI/9rv+D
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c515319dd89so17829966b.1
        for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2026 05:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795180728; x=1795785528; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YAQTVNIYZ/0Tbx2obltQhn42YTPBHmmwY733kBIibzM=;
        b=UI/9rv+DZdDezz6z4q5V4bbLRvq2PUwTXKvmGLgkStPFRG3MFzpLEzZUOMicEVzjqv
         h9WskxL6pQRjVp6LW7wNLul6TdE5DMEMvMtKHVto1kDWUtXl4YZysNnP5izuUm6Wyf00
         02kOc+/ogItTG9aLvdGftl8BuwMr3ddEGZP8CscGYWnM7MnxJ1gdPDJRCMKsqAHhAduA
         5fYf+0m8yQ6qc78NG4siN795mYwXAc6BQzyhcrtUI3sLGXErAQdCZNzpNCRSgoDhZ53Q
         BTlXcoGhXILqja8hQmBbLSiQNTaIckFhQCA59sphyqAh5AgpCytcMtf2fggUT1oBCS51
         FT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795180728; x=1795785528;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YAQTVNIYZ/0Tbx2obltQhn42YTPBHmmwY733kBIibzM=;
        b=Y+hpaUxFZ0/k3QA9rwUufARq5Cg/pV4zjECpumcXJ80QCKTU/goTCdt1kg6uPcvs2Z
         035cfL9PTBHNQkdLWSKwIMvVfQVEyNE5o08Gg+dyhJdQdVIPoo2cxaeXLfo14g8LX4ET
         /Wo+VINzxsvjcQbPc3GjCcphXrtATiVvRMIQFgv4u+wNw/xWq/CdbepYZPphuxoPl90r
         EedB3dm5/NEFlRzOcoNAFoONs3RpP/mErBVmPVLDGhB6LFZEVBVR/wQqvGN1oUFmAie6
         PrqHqcPG3efTKSDJmphrW3yPl/aWDx/od8tBcKPqC9DLffzG5WeYvllW6ED3VPxAt6gs
         TnEg==
X-Forwarded-Encrypted: i=1; AL+hErE29CFLdk+jiQh4gMwvYsjdw0kpUGyvXEdyIvnOaJdZ1w91hL/V3uMsQhaQQgV5VzIYS68vkMVZjqrj@vger.kernel.org
X-Gm-Message-State: APuU4Z8MBOraL2bJtUEAtZpa1ldcBH+Ro+qWg32joHZafUGhnh0nxsXu
	UnJ2XEdHPQ89GS7A8bY5Cai/3Tybs/UpW0iuxRwViWH8+BBna0BRvtbtXtPxe3o/Vhtl
X-Gm-Gg: AYBFou2/gGQ2IsVf7j6uB5NrR7aPk/kHjWcjRsk016E7sffImHvYegobrYx4C6ManfS
	kWxaL0YuBH9GfwJRqytfb3/0sKiRsieF0e+7NZfP/9QG7qlP1QK+CcUEhJeJyCycepvyzEFELOi
	eI6u+Ld7mngqznXrtF4c+34EKE8kSfPsqiRVY8sSuR/KyB5hKqQnRAwVkw79po4wSwhKvRXc7kg
	5GuPIH197Rw7wA+NLU/K5SvoEFJZ3ohgtoxToAQVcplfFpgxSHb6Z/7F+cr+2auIJ11YgBr3d0e
	4rAL+F8MN9FQPmsx30EhtoLMGVDcoQ3IQ6CKo1vjqpQRyONOeVr2QAGxXHNrlBLE6nXhT6LhcLl
	ienyUGva6QVwjKEu1x6TL0pu98NGuBsOoJo9+eIoC2orMbsOwiMvuPPkl6bGq5Nl2MNW9RkDdmI
	c95xaCB+cBHyEdiVVJXUuGw4EmVQs4hHvzNNhgWjhRNz6BDM7I+gAYDWJXXJZ/0wY4hTmLhzIeF
	Zd+GfJdfRTmfqRe0mnMYkBHx+IIru4GgvQraAlp1XjGdZzr2RdoMM7QXanch/SoygCgFSU/a7O5
	V+iVg62SJqljA5hVmhnUs8J1WHTsMODg7Gn3dIucvHNl58B36V4jN7arNuzmSWgZVA==
X-Received: by 2002:a17:907:a890:b0:c41:55b4:d88b with SMTP id a640c23a62f3a-c513ab14402mr338807466b.43.1795180728386;
        Fri, 20 Nov 2026 05:18:48 -0800 (PST)
Received: from [10.0.0.233] (tmo-084-188.customers.d1-online.com. [80.187.84.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513acfe3b0sm93731066b.8.2026.11.20.05.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:18:47 -0800 (PST)
Message-ID: <e376c8f0ec5c50b417375197a5589a210f151d9b.camel@amutable.com>
Subject: Re: [RFC PATCH v4 03/14] rootns: Track init lifecycle via
 copy_process() and pid_namespace
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>,  Andreas
 Larsson <andreas@gaisler.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski	 <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>,
 Anna-Maria Behnsen	 <anna-maria@linutronix.de>, Arnd Bergmann
 <arnd@arndb.de>, Ben Segall	 <bsegall@google.com>, Borislav Petkov
 <bp@alien8.de>, Casey Schaufler	 <casey@schaufler-ca.com>, Catalin Marinas
 <catalin.marinas@arm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>,
 "Christophe Leroy (CS GROUP)"	 <chleroy@kernel.org>, Chris Zankel
 <chris@zankel.net>, Dave Hansen	 <dave.hansen@linux.intel.com>, David
 Hildenbrand <david@kernel.org>, David Howells <dhowells@redhat.com>,
 Davidlohr Bueso <dave@stgolabs.net>, "David S. Miller"	
 <davem@davemloft.net>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Frederic Weisbecker <frederic@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, "Hallgrimur H. Gunnarsson"	 <halg@google.com>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller	 <deller@gmx.de>, "H.
 Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,  "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, Jan Kara
 <jack@suse.cz>, John Johansen	 <john.johansen@canonical.com>, John Paul
 Adrian Glaubitz	 <glaubitz@physik.fu-berlin.de>, Jonathan Corbet
 <corbet@lwn.net>, Josef Bacik	 <josef@toxicpanda.com>, Juri Lelli
 <juri.lelli@redhat.com>, Kees Cook	 <kees@kernel.org>, K Prateek Nayak
 <kprateek.nayak@amd.com>, "Liam R. Howlett"	 <liam@infradead.org>, Lorenzo
 Stoakes <ljs@kernel.org>, Madhavan Srinivasan	 <maddy@linux.ibm.com>,
 Magnus Lindholm <linmag7@gmail.com>, Manfred Spraul	
 <manfred@colorfullife.com>, Mark Rutland <mark.rutland@arm.com>, Matt
 Turner	 <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Mel Gorman
	 <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko	
 <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, Mike Rapoport	
 <rppt@kernel.org>, Neal Gompa <neal@gompa.dev>, Nicholas Piggin	
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Moore	
 <paul@paul-moore.com>, Paul Walmsley <pjw@kernel.org>, Pavel Tikhomirov	
 <ptikhomirov@virtuozzo.com>, Peter Zijlstra <peterz@infradead.org>, Randy
 Dunlap <rdunlap@infradead.org>, Richard Henderson
 <richard.henderson@linaro.org>, Rich Felker	 <dalias@libc.org>, "Ritesh
 Harjani (IBM)" <ritesh.list@gmail.com>, Russell King	
 <linux@armlinux.org.uk>, Serge Hallyn <sergeh@kernel.org>, Shrikanth Hegde	
 <sshegde@linux.ibm.com>, Shuah Khan <skhan@linuxfoundation.org>, Steven
 Rostedt	 <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>,
 Sven Schnelle	 <svens@linux.ibm.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>,  Thomas Gleixner	 <tglx@kernel.org>, Valentin
 Schneider <vschneid@redhat.com>, Vasily Gorbik	 <gor@linux.ibm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Vlastimil Babka <vbabka@kernel.org>, Will
 Deacon	 <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Zygmunt Krynicki <zygmunt.krynicki@canonical.com>
Date: Fri, 20 Nov 2026 14:18:43 +0100
In-Reply-To: <20261119224312.1037966-4-jarkko@kernel.org>
References: <20261119224312.1037966-1-jarkko@kernel.org>
	 <20261119224312.1037966-4-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-11-20 at 00:43 +0200, Jarkko Sakkinen wrote:
> A root namespace needs to record its init thread group's PID when
> bootstrapped and capture its exit status once all processes in the
> root
> namespace have terminated, without serializing normal fork() and
> exit()
> paths inside the container.
>=20
> Commit the bootstrap child reaper, bind pid_ns->rootns, and wake
> waiters
> in copy_rootns() after attach_pid(PIDTYPE_PID), and invoke
> exit_rootns()
> from zap_pid_ns_processes() after the root namespace's PID namespace
> has
> killed and reaped all member tasks.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> =C2=A0include/linux/pid_namespace.h |=C2=A0 4 ++++
> =C2=A0include/linux/rootns.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
15 ++++++++++++++
> =C2=A0kernel/fork.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> =C2=A0kernel/pid_namespace.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 ++
> =C2=A0kernel/rootns.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 38
> +++++++++++++++++++++++++++++++++++
> =C2=A05 files changed, 62 insertions(+)
>=20
> diff --git a/include/linux/pid_namespace.h
> b/include/linux/pid_namespace.h
> index b20baaa7e62b..6fd959f4d0d4 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -15,6 +15,7 @@
> =C2=A0#define MAX_PID_NS_LEVEL 32
> =C2=A0
> =C2=A0struct fs_pin;
> +struct rootns;
> =C2=A0
> =C2=A0#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
> =C2=A0/* modes for vm.memfd_noexec sysctl */
> @@ -45,6 +46,9 @@ struct pid_namespace {
> =C2=A0	struct user_namespace *user_ns;
> =C2=A0	struct ucounts *ucounts;
> =C2=A0	int reboot;	/* group exit code if this pidns was
> rebooted */
> +#ifdef CONFIG_ROOTNS
> +	struct rootns *rootns;
> +#endif
> =C2=A0	struct ns_common ns;
> =C2=A0	struct work_struct	work;
> =C2=A0} __randomize_layout;
> diff --git a/include/linux/rootns.h b/include/linux/rootns.h
> index 3f59415efadb..0557ce75195d 100644
> --- a/include/linux/rootns.h
> +++ b/include/linux/rootns.h
> @@ -13,6 +13,8 @@
> =C2=A0struct file;
> =C2=A0struct nsproxy;
> =C2=A0struct pid;
> +struct pid_namespace;
> +struct task_struct;
> =C2=A0struct user_namespace;
> =C2=A0
> =C2=A0enum rootns_state {
> @@ -41,6 +43,9 @@ struct rootns {
> =C2=A0struct rootns *get_rootns(struct rootns *c);
> =C2=A0void put_rootns(struct rootns *c);
> =C2=A0bool is_rootns_file(struct file *file);
> +void copy_rootns(struct task_struct *tsk, struct pid *pid,
> +		 struct rootns *rootns);
> +void exit_rootns(struct pid_namespace *pid_ns, struct task_struct
> *tsk);
> =C2=A0#else
> =C2=A0static inline struct rootns *get_rootns(struct rootns *c)
> =C2=A0{
> @@ -55,6 +60,16 @@ static inline bool is_rootns_file(struct file
> *file)
> =C2=A0{
> =C2=A0	return false;
> =C2=A0}
> +
> +static inline void copy_rootns(struct task_struct *tsk, struct pid
> *pid,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rootns *rootns)
> +{
> +}
> +
> +static inline void exit_rootns(struct pid_namespace *pid_ns,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct task_struct *tsk)
> +{
> +}
> =C2=A0#endif /* CONFIG_ROOTNS */
> =C2=A0
> =C2=A0#endif /* _LINUX_ROOTNS_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 5efceb8d58a7..08fc28ad1eed 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -83,6 +83,7 @@
> =C2=A0#include <linux/fs_struct.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/perf_event.h>
> +#include <linux/rootns.h>
> =C2=A0#include <linux/posix-timers.h>
> =C2=A0#include <linux/user-return-notifier.h>
> =C2=A0#include <linux/oom.h>
> @@ -2576,6 +2577,8 @@ __latent_entropy struct task_struct
> *copy_process(
> =C2=A0					=C2=A0 &p->signal->thread_head);
> =C2=A0		}
> =C2=A0		attach_pid(p, PIDTYPE_PID);
> +		if (thread_group_leader(p))
> +			copy_rootns(p, pid, NULL);
> =C2=A0		nr_threads++;
> =C2=A0	}
> =C2=A0	total_forks++;
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 127a5fd23e70..081c27aa85bd 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -24,6 +24,7 @@
> =C2=A0#include <linux/sched/signal.h>
> =C2=A0#include <linux/idr.h>
> =C2=A0#include <linux/nstree.h>
> +#include <linux/rootns.h>
> =C2=A0#include <uapi/linux/wait.h>
> =C2=A0#include "pid_sysctl.h"
> =C2=A0
> @@ -280,6 +281,7 @@ void zap_pid_ns_processes(struct pid_namespace
> *pid_ns)
> =C2=A0		current->signal->group_exit_code =3D pid_ns->reboot;
> =C2=A0

Dear Jarkko,

> =C2=A0	acct_exit_ns(pid_ns);
> +	exit_rootns(pid_ns, me);

We have a very similar mechanism around pidfd's to track exit
information for a task. As far as I can see we already have (struct
rootns *)->init_pid reference, so we can get exit information for free
(look for PIDFD_INFO_EXIT).

Kind regards,
Alex

> =C2=A0	return;
> =C2=A0}
> =C2=A0
> diff --git a/kernel/rootns.c b/kernel/rootns.c
> index 3bbf7677080e..bde7cf4baebe 100644
> --- a/kernel/rootns.c
> +++ b/kernel/rootns.c
> @@ -183,3 +183,41 @@ bool is_rootns_file(struct file *file)
> =C2=A0{
> =C2=A0	return file->f_op =3D=3D &rootns_fops;
> =C2=A0}
> +
> +void copy_rootns(struct task_struct *tsk, struct pid *pid, struct
> rootns *c)
> +{
> +	if (likely(!c || !is_child_reaper(pid)))
> +		return;
> +
> +	scoped_guard(spinlock, &c->lock) {
> +		if (c->state !=3D ROOTNS_FORKING)
> +			return;
> +		ns_of_pid(pid)->rootns =3D get_rootns(c);
> +		WRITE_ONCE(c->init_pid, get_pid(pid));
> +		WRITE_ONCE(c->state, ROOTNS_RUNNING);
> +	}
> +	wake_up_all(&c->waitq);
> +}
> +
> +void exit_rootns(struct pid_namespace *pid_ns, struct task_struct
> *tsk)
> +{
> +	struct rootns *c =3D pid_ns->rootns;
> +	struct task_struct *leader;
> +	int status;
> +
> +	if (!c)
> +		return;
> +
> +	leader =3D tsk->group_leader;
> +	status =3D (tsk->signal->flags & SIGNAL_GROUP_EXIT) ?
> +		 tsk->signal->group_exit_code : leader->exit_code;
> +
> +	scoped_guard(spinlock, &c->lock) {
> +		c->exit_code =3D status;
> +		WRITE_ONCE(c->state, ROOTNS_DEAD);
> +	}
> +
> +	pid_ns->rootns =3D NULL;
> +	wake_up_poll(&c->waitq, EPOLLHUP);
> +	put_rootns(c);
> +}
