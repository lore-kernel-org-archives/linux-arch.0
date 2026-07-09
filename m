Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAE3806DA
	for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2026 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584979; cv=none; b=JeUmch6hZCxAC9211ohwbr7PEfFWo3aBInGgCOrzKdmd7T3l44WUGDtpngI6aRAI0eNZTqmwmMrv8qluW/bJT1W1j8EmO8OOhbhOO7qrCL7jZx77Vzz23M5JGN5TOqtdUCe6tuZFLYe3p1lvOc+iBTaN7qUr3tcoXXXMdL/yIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584979; c=relaxed/simple;
	bh=vMvzVDyhwRVZ9mU/uGek2iqLm5M9Oc3aOzpsUrM1kxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBneuLA8DOwefoUOmM1dHS2a1ZsZYUs30Tc6Uo1HU4R19dHfv7ww02jHNu2b/OsM9UAL3zOx5kSrZpelYEr1R16UsN7JwqsuP45Rn6TWXhAUsqGr5PPzF/F7UvDWeKun1CJXDm5VtnReo+fNNp8TffL+Vw23KIdKJ4kCOme2++Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BvFrVRoe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BvFrVRoe"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493e497643fso8555595e9.0
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2026 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783584976; x=1784189776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z+CFlNGgVOBUKoyPjKhrOhvumBe76lgJlilpAZoLH+g=;
        b=BvFrVRoeLdX9K67kasMhrWS3/kUZ3sUPj+VTdiYOPJrmUJ2OVcYURmwa5PSTGOl80p
         EKMqIJlyhLMJIDKcjk/Uupo22TEgpkVnjJ3miA+2E6zuDJECj4soGqwzKsL0HzzQUH4c
         kmSzGWLSqlgnxW9Kig//yvcbRE58E7qwLWaM70bo6Y8pu6+BQMQtY6J1ytMSDWQIHRYk
         BhSVn9FzF8ZLqhxyoL+F20K+CvCwkYwbkpIRWa3zP6tf04lYKxrWcOk0koGiilHLjWyh
         0/xUZkcbeb1xgpVL7F6EvzAeQHxKAf+g5kby0g8tvIK6H0+8v+A32sHsdg2XmTJ6iuSL
         jnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783584976; x=1784189776;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+CFlNGgVOBUKoyPjKhrOhvumBe76lgJlilpAZoLH+g=;
        b=iGTAzMTTWeI333WfjNmTkSFYZri+HGVJang9mJXi2IYeI3ym/VGA0lHTJYrMJ8d9Tl
         JhHYE6fAT3yfCZRFBrCW1fe22YeDIQyxB49E2wctI9wstkLjxhX+qeXZcHREjTyMyGHL
         jGyrgnHDyjMESzzLPPOMGpUNj+ng4L2GxkUtGT8GLX02vbI9HpNi+e/9h8PyL392vpj+
         A2rpk6mGHMLYlhVRvHZ4OJIzmDxpCZRNrPdAH8/fHwHKH5e1ZA8kkutiqCx+tJCCpRUf
         BO5gVt5wjBeXWCuGJE8BNX2F/5zv3KoUxJKTYgE3WEObcUYlMQ2irWYHf9Pm9nOdHHSu
         rAMA==
X-Forwarded-Encrypted: i=1; AHgh+RrSKA3wBgXi1IiK15IpP+ZcDWkzksqYNDqj1QPrvTfjADanaPo9CX5iaTtwHpOuYfcF0ZEiC0trRrg5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo9B7B41LSpwU4xjAyUGbKr2FasIEueMYajWYw0hVx9tdqoFyH
	JxWny6RfgdkT7s0A5HB15zgg3xEyolpQXxHn0EnBsyQoBDotMrY/nk0MHhU0QWknvcA=
X-Gm-Gg: AfdE7cneSloAK9FzINujX98EQlRzKnwuAwRsr8c41PNBBJO8cg7JGFg2JHqOAGfByiR
	1cbo8msnlWVjc3Jmjvw8uWo6big2b7RsDWpFKVHbvGgm+0MDNz9GqOXOaZXixo3D1eXG29TcA9y
	uRolseJj5nZOrbjwbmv80SHViTvibBB+XXunwYgCCAQBT7Lvw4DMltz6K0jia3jWICo6nC8MO+e
	vH7XXWyRHP3z/HvIMQJeheH8L9X6OzOebN9kAk5DOEOK1tM6/uen56ihNxpj4zTZX04URhaCeof
	81voyRgElnZrU3LdG/GaWhYzitlKXQCm+nHd89I+LJhkbZwDpLdmM7hiVwFYQyKtw/RBmUiW36B
	a7mb24EScOsYVgmDs8COYulY64M1GohCGkLL9wyPKUUSfn/FRsHjG6ayLNUQxVeAlmXpjosEmCy
	UalmA9Rghe+qadmk4=
X-Received: by 2002:a05:600c:1d1e:b0:492:7084:32af with SMTP id 5b1f17b1804b1-493e68bf03amr56205565e9.23.1783584976164;
        Thu, 09 Jul 2026 01:16:16 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ee2bcac0sm20177645e9.0.2026.07.09.01.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 01:16:15 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:16:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Eugen Hristev <ehristev@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 21/26] printk: Register information into meminspect
Message-ID: <ak9YzK_Puejpg_du@pathway.suse.cz>
References: <20260708-meminspect-v3-v3-0-7aa5a0a74d5c@oss.qualcomm.com>
 <20260708-meminspect-v3-v3-21-7aa5a0a74d5c@oss.qualcomm.com>
 <ak4Cr5GEMdo8xWqu@lucifer>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak4Cr5GEMdo8xWqu@lucifer>

On Wed 2026-07-08 08:59:26, Lorenzo Stoakes wrote:
> On Wed, Jul 08, 2026 at 11:02:00AM +0530, Mukesh Ojha wrote:
> > Annotate vital static, dynamic information into meminspect for debugging
> >
> > Static:
> >  - prb_descs
> >  - prb_infos
> >  - prb
> >  - prb_data
> >  - clear_seq
> >  - printk_rb_static
> >  - printk_rb_dynamic
> >
> > Dynamic:
> >  - new_descs
> >  - new_infos
> >  - new_log_buf
> >
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -49,6 +49,7 @@
> >  #include <linux/sched/debug.h>
> >  #include <linux/sched/task_stack.h>
> >  #include <linux/panic.h>
> > +#include <linux/meminspect.h>
> >
> >  #include <linux/uaccess.h>
> >  #include <asm/sections.h>
> > @@ -518,10 +519,17 @@ static u32 log_buf_len = __LOG_BUF_LEN;
> >  #endif
> >  _DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
> >  		 PRB_AVGBITS, &__log_buf[0]);
> > +MEMINSPECT_NAMED_ENTRY(prb_descs, _printk_rb_static_descs);
> > +MEMINSPECT_NAMED_ENTRY(prb_infos, _printk_rb_static_infos);
> > +MEMINSPECT_NAMED_ENTRY(prb_data, __log_buf);
> > +MEMINSPECT_SIMPLE_ENTRY(printk_rb_static);
> >
> >  static struct printk_ringbuffer printk_rb_dynamic;
> > +MEMINSPECT_SIMPLE_ENTRY(printk_rb_dynamic);
> >
> >  struct printk_ringbuffer *prb = &printk_rb_static;
> > +MEMINSPECT_SIMPLE_ENTRY(prb);
> > +MEMINSPECT_SIMPLE_ENTRY(clear_seq);
> >
> >  /*
> >   * We cannot access per-CPU data (e.g. per-CPU flush irq_work) before
> > @@ -1238,6 +1246,10 @@ void __init setup_log_buf(int early)
> >
> >  	local_irq_restore(flags);
> >
> > +	meminspect_lock_register_va(new_log_buf, new_log_buf_len);
> > +	meminspect_lock_register_va(new_descs, new_descs_size);
> > +	meminspect_lock_register_va(new_infos, new_infos_size);
> > +
> >  	/*
> >  	 * Copy any remaining messages that might have appeared from
> >  	 * NMI context after copying but before switching to the
> 
> Overall exposing live dynamic printk information to drivers seems unwise, but
> not quite as insane as some of the other stuff thus exposed...

I agree that we should be careful with exporting symbols.

Well, if I get it correctly then at least the printk-related symbols
are already exported a similar way using vmcore_info.h API,
see log_buf_vmcoreinfo_setup().

Best Regards,
Petr
