Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619663A1E69;
	Wed,  8 Jul 2026 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497333; cv=none; b=MG+SC05TTLSyzAAqMjw1XpRcbY/unpM2XZBsk5zYkAVSF8NtZWEVmh3YbOeFPmvIihpCkHw47JTHbPbnsAKXZ1z6PlxZ/y18tD5BGJfYeKgHp3gHpRUhUsxo7k+KHH85L57Y31QVInJP+XhS63r8EIvqM4KYqLH0EpRIBjKvYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497333; c=relaxed/simple;
	bh=cFqinEafZe+E/zME4VUnOHBN5JjLYv6Wo/u8UdjY8Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTn5Fr6xe0GkU4t6tABphljxos9DkFBAp6IikWpGGM8e4S6YYsMbLEv9/uPnXbz5Be0Y1qpftwlq1JIErr+s08qFGE9QmeNAf1lTbU0VrbiY74mrSRdKI8DO0crL9aOYP5zI0zGzdoOMxWoVedBTzdBpb6MH5nwsOBBQY7pHHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGcrgBs5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGcrgBs5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF31E1F000E9;
	Wed,  8 Jul 2026 07:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783497320;
	bh=FGLD0lBwBOza5qGEuYHyTEO5snzgDd2JCF7uerUmJDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mGcrgBs5/vg3Vd5SnHL7lqtCAfSCfHWs8GW3AEUmce9wsmWNv9ojKUWfDuosr3A2B
	 /9pUOQBlEzNtTgB+gLQ8GEnbi9ShdWvpKuXDqkEm899h0/1Ga+sR9Kiq0Iqf2FiJMo
	 wDAdqZIYR0utJM5INXn83bOaSZ3xyggKrKT+vwNJ5/t/Gb2agcM6NHcjq/ZvEV6038
	 y5BpkB6eUBFrSheOv3jiYSvx03nzO90M1tNHyKDiQzIsoWFIHUXEX0GrkbbzPaCNTT
	 6/IT4fwRhj++fdu8RM4V2hEiNk4FecbuMwGdIQ5anvuP+uyrhYNhuyWtPjEvo8byb3
	 5tb+Yx37WTMmA==
Date: Wed, 8 Jul 2026 08:55:00 +0100
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
Subject: Re: [PATCH v3 19/26] mm/numa: Register node data information into
 meminspect
Message-ID: <ak4B8L57VDYFGGIh@lucifer>
References: <20260708-meminspect-v3-v3-0-7aa5a0a74d5c@oss.qualcomm.com>
 <20260708-meminspect-v3-v3-19-7aa5a0a74d5c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-meminspect-v3-v3-19-7aa5a0a74d5c@oss.qualcomm.com>

On Wed, Jul 08, 2026 at 11:01:58AM +0530, Mukesh Ojha wrote:
> Register dynamic information into meminspect for debugging:
>  - dynamic node data for each node
>
> Use meminspect_register_pa() to collect node data into meminspect.

This commit message is a total mess, this feels like internal development stuff
not something you're trying to get upstreamed in core.

>
> Co-developed-by: Eugen Hristev <eugen.hristev@linaro.org>
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  mm/numa.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/numa.c b/mm/numa.c
> index 7d5e06fe5bd4..f04740dfb2cb 100644
> --- a/mm/numa.c
> +++ b/mm/numa.c
> @@ -4,6 +4,7 @@
>  #include <linux/printk.h>
>  #include <linux/numa.h>
>  #include <linux/numa_memblks.h>
> +#include <linux/meminspect.h>
>
>  struct pglist_data *node_data[MAX_NUMNODES];
>  EXPORT_SYMBOL(node_data);
> @@ -20,6 +21,7 @@ void __init alloc_node_data(int nid)
>  	if (!nd_pa)
>  		panic("Cannot allocate %zu bytes for node %d data\n",
>  		      nd_size, nid);
> +	meminspect_lock_register_pa(nd_pa, nd_size);

Not keyed on node ID, just exposing the physical address assigned to a node to
all drivers.

Nope to this.

>
>  	/* report and initialize */
>  	pr_info("NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,
>
> --
> 2.53.0
>
