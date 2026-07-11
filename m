Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1D31ED83;
	Sat, 11 Jul 2026 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783784641; cv=none; b=jOzUzj/co6awXfddL5QCPA2iVaK1tPJxx03hPfTQjniDEr7L+2VVoOVptwMeb1GRFegfHAhvVb2ePNuJsb4jnNaldEt0O7ehu90s55nBhnMpx+qJP4Gd2oZdRZszWhcLFL7v9sTBU3Tc2nDaSYlHfHxxQbs3KaJiGvYufLuFWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783784641; c=relaxed/simple;
	bh=mhFa22vO3qS0/hStH0WuAGzS0XraLdV3PN7ZfZVHf/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLhHf9fuoDse9xNYxIKvWOP1814OGiy3mJwpevelF8fkP3+S7YZKXWG2J63cuelCPikYXezm2h3M1SuTXLYbyCE5L1Sk0bVePmQBT1sTonkegD3wlX4gpqFgja+WbQzIP3cSI6ubjSnAPqgOEAzG4kRMIF+lXcj/VnU3aoBXdM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIAqARcK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIAqARcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C6E1F000E9;
	Sat, 11 Jul 2026 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783784639;
	bh=+Hx51w8dFEncFI58huRfM4bO4YcYrbYiW5us+lxhCn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZIAqARcKP8hujblE64oSTCkc0UZEMo26D7eVRtr0xDhcXILGxalvRvFmMtdghf/bI
	 q7qQctgHJCL6WCDEnzfZDVOe0Aectw75OQfsY1G5tto5Q0WSLIy0Frl6snpWxroSwy
	 Swdl/NBz6s0ZYnNMaB8U5aDNYLrOouKqs+25wP14l7jNzBb3xWc/37FYla9s3u4MAZ
	 g7PRUdo+J80jx0RVD8zD8zo44CNIR3crgyrCUDjCQsEMxzt/PBhDbBoNShaK1xBH/9
	 DWdmt+dD+oobnlbRjWzj0rOnAtXSOlOmDsBsDGjFIetPZEjlaem3yegxLO9pjx4qXk
	 5e/HWkVwggiMg==
Date: Sat, 11 Jul 2026 17:43:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
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
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 25/26] dt-bindings: reserved-memory: Add Google Kinfo
 Pixel reserved memory
Message-ID: <20260711-tested-elite-dingo-93efc8@quoll>
References: <20260708-meminspect-v3-v3-0-7aa5a0a74d5c@oss.qualcomm.com>
 <20260708-meminspect-v3-v3-25-7aa5a0a74d5c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708-meminspect-v3-v3-25-7aa5a0a74d5c@oss.qualcomm.com>

On Wed, Jul 08, 2026 at 11:02:04AM +0530, Mukesh Ojha wrote:
> +maintainers:
> +  - Eugen Hristev <eugen.hristev@linaro.org>
> +  - Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> +
> +description:
> +  Reserved memory region for storing kernel debugging information that
> +  can be read by firmware and bootloader on Google Pixel platforms.
> +
> +allOf:
> +  - $ref: reserved-memory.yaml
> +
> +properties:
> +  compatible:
> +    const: google,debug-kinfo

I guess: google,pixel-debug-kinfo

Or maybe even specific SoC. Both title and description suggest this does
not apply to other Google devices (makes sense), so compatible should be
somehow more specific, unless debug-kinfo is already enough to identify
possible users and there is no conflict with debug-kinfo in Chromebooks,
for example?

Best regards,
Krzysztof

