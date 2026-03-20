Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D50B652;
	Fri, 20 Mar 2026 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976259; cv=none; b=m2PD5ATmQDVcZcQeh7NEQfPMAzAZ6Tbh+KopkUivl+cGI2JLRRdkRB9jhfSYvUlaW/bjar4aCIttFBU3AjjPw8qv3/ZJbZ9RBpyvj+az31uKdB1/KmigL0x4etY+dsYbRB8nadkTbEgbjK4Hr5K0vo4G4BSkMUkSh36j7c3MRtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976259; c=relaxed/simple;
	bh=PWVgh1useoiif8rGVsyxHxI0CYpzSQvYe+hudbWgJgk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZAlTynzlkItwDTyNjKeg2RJsjVo3z+C1Or5XtCexXjvpfssLHgjbZfTGaRE5DKMkiGIsfLQoFNzjWOg9x+oau64qiofhdsgbiu03SmhuS3ccO/8HBrnD5sRobhGr6weNYPxhnIzDTMxUcZmGcmR5oTwqEMdJW0vjEcEFW/h1h6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=z71svX0W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="z71svX0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA4DC19424;
	Fri, 20 Mar 2026 03:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773976259;
	bh=PWVgh1useoiif8rGVsyxHxI0CYpzSQvYe+hudbWgJgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=z71svX0W9IEG9X0CljZclwmdPxrS2xt0DgkYPV0miyW6uLliBKplyUI9cqLWsAMID
	 HknlgTOQAMOZMIJ0rHvOhVmKRO4JG7rzBzNqhHQadyrhW2vHnOnPmp9Trx7zagjUeA
	 Gp5Uj70ZJr6CbF0U6zE8qTTGLs0kE3eFTNqcLYV0=
Date: Thu, 19 Mar 2026 20:10:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Kees Cook <kees@kernel.org>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Uladzislau Rezki
 <urezki@gmail.com>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrey Konovalov
 <andreyknvl@gmail.com>, Marco Elver <elver@google.com>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Peter Collingbourne <pcc@google.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH 0/3] KASAN: HW_TAGS: Disable tagging for stack and
 page-tables
Message-Id: <20260319201057.05d57006408a2f77342eedc2@linux-foundation.org>
In-Reply-To: <20260319114952.3241359-1-usama.anjum@arm.com>
References: <20260319114952.3241359-1-usama.anjum@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 19 Mar 2026 11:49:43 +0000 Muhammad Usama Anjum <usama.anjum@arm.com> wrote:

> Stacks and page tables are always accessed with the match‑all tag,
> so assigning a new random tag every time at allocation and setting
> invalid tag at deallocation time, just adds overhead without improving
> the detection.
> 
> With __GFP_SKIP_KASAN the page keeps its poison tag and KASAN_TAG_KERNEL
> (match-all tag) is stored in the page flags while keeping the poison tag
> in the hardware. The benefit of it is that 256 tag setting instruction
> per 4 kB page aren't needed at allocation and deallocation time.
> 
> Thus match‑all pointers still work, while non‑match tags (other than
> poison tag) still fault.
> 
> __GFP_SKIP_KASAN only skips for KASAN_HW_TAGS mode, so coverage is
> unchanged.
> 

Some questions from Sashiko:
	https://sashiko.dev/#/patchset/20260319114952.3241359-1-usama.anjum%40arm.com
