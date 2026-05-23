Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7BD39478F;
	Sat, 23 May 2026 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779538267; cv=none; b=T5LXgDyFJZFBGJdlZySH6g8ApZ+HmW0Fifab5p3Thdxef6PEjWD+SrRjTwQLBfTwmXhcSLPybkdUHuIkMwdX+oq8VisTw/imOzKOEtgBag8lvVsTs/BMCmRr6WWDsms/TNKQhDG5XgTwrz1uqYsfzpCeG1MqZ4xkJ0PWEStnEww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779538267; c=relaxed/simple;
	bh=DB4yS0bX8LI+TdUgQibgO35GpN1xBKKecis3CQ0Rl68=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=pupx3qMKb9wTHs4EfKYyzL/y6BlDnhQ1gk0/FP0VMUR1y88mV73FwbLHmEeSgev1R0X+N+aVSbTqgchiMLa+N2j9eNUg/FTnf8nHxjmHnDFaZ7G5NJZrLvx1It3SFEclGWDXSi3IyCBsZbpWVrwEWdOTXIa7MMLDNYj9qvQ8QIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F734qm7D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F734qm7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8691F00A3A;
	Sat, 23 May 2026 12:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779538266;
	bh=UjlwWAFQXurCmVH5SfbVuNoim1TKpkRokW4Dr7IwTnU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=F734qm7DZYLMFADDYXRhEEKKvO0INAdvAbkN3rksN41lQDigKzrgtYo8Xxv8U5Vmb
	 ek+euMDdHxoneKhlPmQ8h0ublMO3gxujCiGTYt95AwTYrWCPhFvhrEJ71asYrSMutK
	 ep1cnw6iHy5KNzi52qKENsImnqUWMjaIgPPLxoSmdcEwtrfQ+U0baumO6HN4XmFWf+
	 nkfQeo7wJbGsZjrTn3yN1beMZgeMovsd53Kc5NGoUHjtZo3UW1COTSxcL0M+IZ6pei
	 7WHpYS1KrXGdF9AUHcV2q6viwuDXwQnnNXuGBYP9cQhcrTSNioWbj/dLfnQfROaBwT
	 6BCRx+xsG9Zng==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/7] mm: add a set_page_section_from_pfn() helper
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: apopple@nvidia.com, akpm@linux-foundation.org, arnd@arndb.de, 
 bp@alien8.de, dave.hansen@linux.intel.com, david@kernel.org, 
 mingo@redhat.com, rppt@kernel.org, tglx@kernel.org, kees@kernel.org, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, x86@kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260521040124.10608-3-lizhe.67@bytedance.com>
References: <20260521040124.10608-1-lizhe.67@bytedance.com>
 <20260521040124.10608-3-lizhe.67@bytedance.com>
Date: Sat, 23 May 2026 15:10:52 +0300
Message-Id: <177953825217.3959652.5821431794861471690.b4-review@b4>
X-Mailer: b4 0.15.2

On Thu, 21 May 2026 12:01:19 +0800, Li Zhe <lizhe.67@bytedance.com> wrote:
> Callers that want to update section bits from a PFN currently need to
> open-code:
> 
> 	set_page_section(page, pfn_to_section_nr(pfn));
> 
> and guard that sequence with #ifdef SECTION_IN_PAGE_FLAGS.
> 
> [...]

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

