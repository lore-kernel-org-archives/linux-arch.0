Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29F53E8685;
	Wed,  8 Jul 2026 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496908; cv=none; b=UyBMmjue7W88LrvZnRTh1Y3FF/4EQ5h9/LUYD4CilBPGthA1q0AyxrAVergqqNFFHykk+41Bb3ZpKoqUeZMs8QFnV2znziJDIUn1VpE1YFqkSyjhlMCRptIK++GSR5RY8exnByYEvQr1BEnoSLAmM3/Pw4W9CM3huvqqbucQrKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496908; c=relaxed/simple;
	bh=x+g7k2KKI6hfDtJZ+4b3/wXjpV/OYRwxYBBqqZpVeco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pa73ZYppgH8bpnxOA0f+pnBl8RpWggWEgEq+s/O90O6uOjvjCwxV7KGKa+TtTj8PG5cQYu8bg0pthtJjBaj74rvf0UJFqp5aNAY1nciNHYLEUzd7jNDAANLheQmxA9UUF6XROnB3lnXEcS2PAIPmQBZ3wEul2w+J+XL5R5xu+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjJlrrq2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjJlrrq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58581F000E9;
	Wed,  8 Jul 2026 07:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783496892;
	bh=3OevjrqXdRJOTrMJtKKzkDBmycrF0jmHB4LMFtbouHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LjJlrrq2oFTukn2i1pCUeSiArZM+6hQwNFxPYuh/g4jt66M47+7zhAhVufrXJTXvk
	 AYGtWhiMJP8oNmL8n8nXqUgv6HcBAi0TGS6ok7M3saBtRWkgpxKgGjhPam/vaNydxr
	 CHIJLBeX77gHZsupfpi6opKk03yZQ8eKPbuUn4pn3WL92SCHv2VSxiLF0NCmigi5ro
	 CFqHb+DMeL6sc73iLwtBHsA/jRtqZvbJdwhlvt3z+168bJLs0cz+8ixPo3/IuOv3rN
	 HiBlWecG0OBlYEX9SIrBUR4iWn573796Y/jk1BCDlj+rRRWhUoXoRKebDzZQ0UpIvm
	 MK4PX9aO5dTzQ==
Date: Wed, 8 Jul 2026 08:47:51 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Eugen Hristev <ehristev@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Kees Cook <kees@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 11/26] mm/swapfile: Annotate static information into
 meminspect
Message-ID: <ak4AgXqMnkn8rVGE@lucifer>
References: <20260708-meminspect-v3-v3-0-7aa5a0a74d5c@oss.qualcomm.com>
 <20260708-meminspect-v3-v3-11-7aa5a0a74d5c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-meminspect-v3-v3-11-7aa5a0a74d5c@oss.qualcomm.com>

On Wed, Jul 08, 2026 at 11:01:50AM +0530, Mukesh Ojha wrote:
> From: Eugen Hristev <ehristev@kernel.org>
>
> Annotate vital static information into inspection table:
>  - nr_swapfiles
>
> Information on these variables is stored in a dedicated meminspect
> section.
>
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  mm/swapfile.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index a602e5820513..d480727e4987 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -42,6 +42,7 @@
>  #include <linux/suspend.h>
>  #include <linux/zswap.h>
>  #include <linux/plist.h>
> +#include <linux/meminspect.h>
>
>  #include <asm/tlbflush.h>
>  #include <linux/leafops.h>
> @@ -65,6 +66,7 @@ static void move_cluster(struct swap_info_struct *si,
>   */
>  static DEFINE_SPINLOCK(swap_lock);
>  static unsigned int nr_swapfiles;
> +MEMINSPECT_SIMPLE_ENTRY(nr_swapfiles);

Now the EXPORT_SYMBOL_GPL() is an EXPORT_SYMBOL() in effect no?

>  atomic_long_t nr_swap_pages;
>  /*
>   * Some modules use swappable objects and may try to swap them out under
>
> --
> 2.53.0
>
