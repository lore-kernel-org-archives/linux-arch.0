Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B9C37BE6A;
	Mon, 16 Mar 2026 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653952; cv=none; b=Hdb3NKt3sA05QAf/p2J+Itigtf7+8SWt7P0tipfb/sgSciONbQCWCxaJF206NIQiwazC3hLqDMfZVQpc70CS7z2IAnpSA7UXRBGnO2fOBSysuDHTFiqViKI3WuWuVdDoqivsMSsIv3GlX5fYkz5CDtYMcYmyuB2Eu9F3HHf9+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653952; c=relaxed/simple;
	bh=OL6AhR5XAWCLAFO1ZFhQa7oUctDayRZhVu71HIg1Otc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JSQtd6iFiZEeZ+un0FFngYtGqDzks6TKA1WgUHVUuiiqjwXwX2nE5MerBdP3ijIrx9ZavL8ySXJQbJpcM15mZBEMSDqBc2vYlGT1Qy9A7jUXBjvp0GEdyrgQzQmXT59Xe48Br2Ecue2XsdDQCqISgKllVNmj9wPZLTN0SZWnP80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RGW/SC4M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QGIR75ZP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RGW/SC4M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QGIR75ZP"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773653948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9yXXr7UYzVmKZqbUDqTRxeSr99PDOjbUs7jkHvsTHQc=;
	b=RGW/SC4MMA/M4YgLuQp6J+nCgqUPKuzJkjfow4kMcP+Ja54NkGd+Iqxcg0INU5BTQJaqbd
	zWuxfRRBwiYqp1zn+ygW2r9mucciJZQfAESPJPEVNCw0VFTSF2q5jqNKXze15EE/2LUqgs
	7tBkXd3YwUwloSiTyIIjO2b3BZA4XAkvszc02Wytj120zLFKlqdZ3lc4ozLwb0uXovN+hS
	zpPZPoCg+QW3Ip+nzLaHWLmdk+psjF1q/GdABgeoje1reSUDEUlS94ig22Rd/SWyObLkBQ
	UVGOB0uvxkkbuO6RBzCm7k94ZLRQqqdVogqowh+uurx+9xqS/e59L4ZyOvGVDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773653948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9yXXr7UYzVmKZqbUDqTRxeSr99PDOjbUs7jkHvsTHQc=;
	b=QGIR75ZP1H0QscPuRjVvpUiSFT4GWZluKBzuY8RFXIJ9I/8MYYYcOktCRI31IQE1Zl+P0h
	QgSBF55PD4+EkVCw==
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Eugen Hristev
 <eugen.hristev@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Dennis Zhou
 <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
 <cl@gentwo.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, Brendan
 Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi
 Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>, Kairui Song
 <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham
 <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song
 <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, Petr Mladek
 <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Bjorn
 Andersson <andersson@kernel.org>, Mathieu Poirier
 <mathieu.poirier@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 20/25] printk: Register information into meminspect
In-Reply-To: <20260311-minidump-v2-v2-20-f91cedc6f99e@oss.qualcomm.com>
References: <20260311-minidump-v2-v2-0-f91cedc6f99e@oss.qualcomm.com>
 <20260311-minidump-v2-v2-20-f91cedc6f99e@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:45:06 +0106
Message-ID: <87pl54f70l.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-03-11, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> wrote:
> Annotate vital static, dynamic information into meminspect for debugging
>
> Static:
>  - prb_descs
>  - prb_infos
>  - prb
>  - prb_data
>  - printk_rb_static
>  - printk_rb_dynamic

FYI: vmcore also exports the symbol "clear_seq". It is not required if
you are interested in reading _everything_ in the buffer. But it may be
interesting if you want to mirror vmcore tool features.

> Dynamic:
>  - new_descs
>  - new_infos
>  - new_log_buf
>
> meminspect uses a different API to annotate variables for inspection,
> and information about these variables is stored in the inspection table.
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Co-developed-by: Eugen Hristev <eugen.hristev@linaro.org>
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
