Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D6B3EBF17;
	Wed, 11 Feb 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770825670; cv=none; b=e6DGE2tjNkXnyYEVW0Jkz75nVXgGEUi858y5b0iENT31jVLfOeZ0wPbRzXP3Nv16L4r0zHuNnYixJk+WBChFL3KJUQB9LQy89FPofs3qv9dXCdOOfuM+71lZnSKDsgWdIHVcHTLp71CqviN+93EGgY0KXYbTX6KiJR17BYjAOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770825670; c=relaxed/simple;
	bh=u08AD1YbiNVGYI3Y2C3r8qA3ry88SvQe0E3MD2DYfZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jm3nvTY5YoI2lVgMLmilJlalZTzjjnR1MkdEPMl8wOS7ia1NBMOaTzndRiEbgyVVxNnviIXj5vMnt31wkbidvLbH+dIrYIQluzff0ECWEHVKDeemOt9gtcRzcv1qhsK2MqgTJfHjq6kxN02j9TRy4oUbjR5nlRTv7qF3kqcIpsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1CBF339;
	Wed, 11 Feb 2026 08:01:01 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.197.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A8943F632;
	Wed, 11 Feb 2026 08:01:03 -0800 (PST)
Date: Wed, 11 Feb 2026 16:01:01 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
	peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH v9 03/12] arm64/delay: move some constants out to a
 separate header
Message-ID: <aYynvZXsuZlcxyZX@arm.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-4-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209023153.2661784-4-ankur.a.arora@oracle.com>

On Sun, Feb 08, 2026 at 06:31:44PM -0800, Ankur Arora wrote:
> Moves some constants and functions related to xloops, cycles computation
> out to a new header. Also rename some macros in qcom/rpmh-rsc.c which
> were occupying the same namespace.
> 
> No functional change.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Reviewed-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
