Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9FB12FF69;
	Sun, 16 Aug 2026 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786896370; cv=none; b=C1mRiI5BvRVEzE77JQXcn1HTp0gD+a1So3ruVrBEsYjC7a+h6MBPTiErvZHM3BIxbgLabbv2LvcTth8VSjCPfRvc0E9tY0+5wdb4cCc3cktZUPljfNKDoDtMCQsxMl5R+1DwYqoIO8Hp3qc/T4r87nrCU1LEShgP/EzZXOzhuaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786896370; c=relaxed/simple;
	bh=ob06hv1anttIim8F0PhXaDp5waSVB8DbUgj5R4QWhwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzizaI4SNq6VBJx40Phw0zPMEG6hGP8ziEA0zUvc722cUKcHH+nQCjL0sgvhpm52lcluLZk3zLfc1VeiTPSo1d3ErmRUBmSPopED/X/n2B6lEHUFNlDdHmZbPnArAw+mnGE23deNLs3ChI6zj7UgQjpqJvxoX+tf9+doTryC0f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ddLBLhVm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ddLBLhVm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=wh8Q7xXUP7NRxIgkMm8b/UxE002fm+JdoQ12PdYpmf0=; b=ddLBLhVm2pkUlMfFjCH0xUPKnw
	3xU9XvBZUsxCPcHhXBKi8g2yIitlPljPZAUSz6jDMkJbxYBYh3Wjy2IiQdV/LvDBmlsyzPFW6h6PE
	vTT6zvPPM32RftHomYGybHjk3JRaHwB5Mvmtq7u3UNJg/OO+HwRrPIAFb+Imt9Q87C6adkLOxiqAv
	AagtEmdwY+zNj2/59e4M1RR3+Gmd1lcfP+AqQloukPDaqQ/oayoDUEOVUhAGrfdiltWp3FY//3J2z
	ihPHRoBZ44zfBTVLw6h6080HCwzEMOQdEnlas761TX91oq5GLHt02s69G0eQGboUOoWGUd7UUsFVI
	cK45QOVw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvdN8-00000004smI-0ehW;
	Sun, 16 Aug 2026 16:06:06 +0000
Message-ID: <61e9bf07-78b5-4696-b467-4c0ff462fe75@infradead.org>
Date: Sun, 16 Aug 2026 09:06:05 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] Test: Added self-testing and documentation
To: mathura kumar <mathura.kumar.tech@gmail.com>, brauner@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, corbet@lwn.net
References: <20260816153811.1085261-1-mathura.kumar.tech@gmail.com>
 <20260816153811.1085261-5-mathura.kumar.tech@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260816153811.1085261-5-mathura.kumar.tech@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 8/16/26 8:34 AM, mathura kumar wrote:
> Add test coverage to verify system call behavior under
> different-different cases.
> 
> Update index documentation to include two new doc.
> 	1) mq_recvmmsg.rst
> 	2) mq_sendmmsg.rst
> 
> The tests validate:
> 	1) Offset boundries.
> 	2) Partial success behaviors.
> 	3) Timeout behavior.
> 
> Documentation changes include:
> 	1) Updated implementation details.
> 	2) Error handlings mechanism.
> 	3) Tests details.
> 
> Signed-off-by: mathura kumar <mathura.kumar.tech@gmail.com>
> ---
>  Documentation/userspace-api/index.rst       |   2 +
>  Documentation/userspace-api/mq_recvmmsg.rst | 205 ++++++++++
>  Documentation/userspace-api/mq_sendmmsg.rst | 168 +++++++++
>  tools/testing/selftests/ipc/Makefile        |   2 +-
>  tools/testing/selftests/ipc/mq_recvmmsg.c   | 392 ++++++++++++++++++++
>  tools/testing/selftests/ipc/mq_sendmmsg.c   | 360 ++++++++++++++++++
>  6 files changed, 1128 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/userspace-api/mq_recvmmsg.rst
>  create mode 100644 Documentation/userspace-api/mq_sendmmsg.rst
>  create mode 100644 tools/testing/selftests/ipc/mq_recvmmsg.c
>  create mode 100644 tools/testing/selftests/ipc/mq_sendmmsg.c

Documentation build warnings (from 'make htmldocs'):

Documentation/userspace-api/mq_recvmmsg.rst:96: WARNING: Bullet list ends without a blank line; unexpected unindent. [docutils]
/work/lnx/repo/linux-next/Documentation/userspace-api/mq_recvmmsg.rst:179: WARNING: Title underline too short.

3.4 start_idx argument
~~~~~~~~~~~~~~~~~~~ [docutils]
Documentation/userspace-api/mq_sendmmsg.rst:77: WARNING: Bullet list ends without a blank line; unexpected unindent. [docutils]
/work/lnx/repo/linux-next/Documentation/userspace-api/mq_sendmmsg.rst:146: WARNING: Title underline too short.

3.3 start_idx argument
~~~~~~~~~~~~~~~~~~~ [docutils]


-- 
~Randy

