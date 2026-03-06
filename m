Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABC52874FB;
	Fri,  6 Mar 2026 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793087; cv=none; b=tbqH5LC6xvo/SFnAfQ0Y5KqO7VoRL8tWJXKniwFl1jbLsOgl+k3OG1TlxXdbhuDmrihWekw3Yh9Wb8ne943LEDRVCh6265nolPVLMnXlAjrYIlrrE9xdllHYK0xQ7Icdy5cS6PqMKOf/D5xKPVzYZIc21ItKdCuPNM6KnEj1QDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793087; c=relaxed/simple;
	bh=4fnqsiuPRlFg7+8dD99oK7wK943f6IziUzz9HAFaq1U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DRLtD6iyYQVmYazCpUr/SPOya1K9Zoh2JGAJ5TSbblXbfbkb4FvhW/EOK6CeHH7x4fQRLlZ1eEH3kPt8E+BQ8sFIz5J+3FfQhFyTi+twftZUtaH5gNJncvB7wJeyAwhUpAfHbGwAa26/zwVFtG4OzCN+ripfo9Tnduf7jwFQrIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IbAw+Ls8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ciyRBOEX; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IbAw+Ls8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ciyRBOEX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B6D91D00231;
	Fri,  6 Mar 2026 05:31:24 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 06 Mar 2026 05:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772793083;
	 x=1772879483; bh=7lVi4wx23gEucWcmPTAuk8q/Qg53flc2xyWX/ahVfiE=; b=
	IbAw+Ls8M5oSI28RI2AVx2AfgHxxFI30uT6wQOZMH5YrPf+vDXKkQXe49DEUeaZ4
	ChA4kVlbLM+vvwVhv5TKjlWcbEIJNsDutNDW9VZjQUlyHnrrSzysekPkDbM2GiFN
	WZ0dPw/eS7sXdNOum3i37cNH8LrVWX/4J2JtWhK1S2xtcAal2bSdTTHgV1j0ziHl
	PPinAmehSQqZ5UlHeOTwkTpsvz8hH/rUxggVhFYnMRiaTdxhCA2q2ijNDRRg/sn6
	49pz80yyFgavJbv7CNqFNWHMLGJHXjy4CELdILxekurf7qUTGfCyzer8q3tAIsJ/
	VJG1xrRhV5zDwl221J0/fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772793083; x=
	1772879483; bh=7lVi4wx23gEucWcmPTAuk8q/Qg53flc2xyWX/ahVfiE=; b=c
	iyRBOEXsNw9TM1hxoVyw3KEpTKBmTCoQqyiARgB0bTltkATMajx0xuSCp2RhcWqr
	M2rKubajdKJnDAbCmj2lJikZWa7jW4XBbkGlhwEgNyHhM6OjGqosWneRYB4VSmL6
	SqzTdbJEbpGmZJyaQU/cxwPMxTzbJS/BNHxWAobfweJkx/qJ4IYWNqVn3nBBeOSK
	kacl+/VyRRvl0NeUAi4v543/Lzfts7G+oYIGO6IktPHU5ulUpKv2vZ/fKWlEwkNv
	PATfMd0bYksX1kpsAjGSw319x2GJZ4lrHwfHYBpJC+EoG950ypnow/pEVbKbxGr9
	BvlhrkbyjXgNLtVqiFVQg==
X-ME-Sender: <xms:-6yqaTwA9uX2sw_jTBEcLDr4voNFPSDIhQlVTQE2mkzIggV-BXsv_w>
    <xme:-6yqaWHV0ggwgwksJHqPO7M6Hhe4_DviVJuQ3ueq7D7QfFpqNa2tdPO-WwdJobIQ4
    A6570YmO94bRqrac1Z1jP3wOJmMPjjk-fMpffripufyzNG8bXGkGiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeltdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprggtrgguvghmihgtudhmrghthhhurhgrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgv
    vghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtg
    hhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnih
    hvrdhlihhnuhigrdhorhhgrdhukh
X-ME-Proxy: <xmx:-6yqaWpGWcn8QbO-xLW-z5rfbUeeQyVHg9XSvK5YQdT-NmIuCVZmoQ>
    <xmx:-6yqaVWlrVSsWT2a_DS2sXmlsCEMBV9GaHvy0zwtaUFRK6l3ml7CpQ>
    <xmx:-6yqaZaXingR_ZBkpF5G2hiHWLfz23S1kZGYJzb3JodgUCUZpK3xwA>
    <xmx:-6yqaaeuyPv4jSZkEZtc2uVTO75pPtCHF9YG48JmHBPnCy5_OO-P0w>
    <xmx:-6yqaaKSKyaZKmHKyre9fZbBf_hdxTjxfzhg52cU2tbE_ijXcokBuIfc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 36DA1700065; Fri,  6 Mar 2026 05:31:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArmtIjJjdzS7
Date: Fri, 06 Mar 2026 11:30:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 Mathura_Kumar <academic1mathura@gmail.com>
Cc: "Christian Brauner" <brauner@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Alexander Viro" <viro@zeniv.linux.org.uk>
Message-Id: <b0398b22-e964-4f7e-b29e-612386730dae@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdXDeeeJH3x09YuZ-86=FPfwZg0mD5Gwnqvk7U_QT1eOhw@mail.gmail.com>
References: <20260306075009.83723-1-academic1mathura@gmail.com>
 <CAMuHMdXDeeeJH3x09YuZ-86=FPfwZg0mD5Gwnqvk7U_QT1eOhw@mail.gmail.com>
Subject: Re: [PATCH] [PATCH V5] mqueue: introduce new do_mq_timedreceive2() [ mq_peek
 syscall] for non-destructive receive and inspection,fix minor issue,prepared
 doc.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 6, 2026, at 10:38, Geert Uytterhoeven wrote:
> CC Arnd

Thanks!

> On Fri, 6 Mar 2026 at 08:50, Mathura_Kumar <academic1mathura@gmail.com> wrote:
>
>> +1) Overview
>> +-----------
>> +
>> +POSIX message queues on Linux provide mq_receive() and mq_timedreceive()
>> +for consuming messages from a queue. Both interfaces require the caller
>> +to pass the message buffer, length, and priority pointer as individual
>> +arguments to the system call. This imposes a fixed calling convention
>> +that cannot be extended without breaking the ABI.
>> +
>> +mq_timedreceive2() introduces a new system call entry point that accepts
>> +message buffer parameters via a struct argument rather than as individual
>> +syscall arguments. This frees the remaining syscall argument slots for
>> +new functionality flags and a message index, enabling non-destructive
>> +peek and indexed access semantics that are not possible with the
>> +original interface.
>> +
>> +Two variants are provided:
>> +
>> +  mq_timedreceive2()         - primary variant, 64-bit time (Y2038-safe)
>> +  mq_timedreceive2_time32()  - 32-bit time variant for legacy and compat
>
> What is the rationale behind adding a new syscall that is not Y2038-safe?

Indeed, that would need a very strong reason. New userspace already has to
support old kernels without the syscalls, and it would seem easy enough
to just not support it on time32 libc implementations.

>> index 4fcc7c58a105..fd90a2f500b6 100644
>> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
>> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
>> @@ -562,3 +562,6 @@
>>  469    common  file_setattr                    sys_file_setattr
>>  470    common  listns                          sys_listns
>>  471    nospu   rseq_slice_yield                sys_rseq_slice_yield
>> +472    32      mq_timedreceive2                sys_mq_timedreceive2_time32
>> +473    64      mq_timedreceive2                sys_mq_timedreceive2
>> +474    32      mq_timedreceive2_time64     sys_mq_timedreceive2          sys_mq_timedreceive2
>
> PowerPC receives three variants?
> Oh, the first two are for 32-bit vs. 64-bit, so they should use the
> same syscall number.

Probably just a typo there (same on sparc), I assume the intention was
to use the same number as the generic scripts/syscall.tbl version.

> Furthermore, this breaks the "new syscalls use the same number on
> most architectures"-rule. Next free slot is now 472, 473, or 474,
> depending on architecture.

Right. I also noticed a few more mistakes with the numbers:

- parisc is missing the syscall entirely
- arm32 compat mode has the numbers reversed compared to native mode
- x86 only gets a version in the 'x32' range, but is missing the
  native x86-64 version.
- The testcase hardcodes the x32 syscall number for all architectures
  other than a couple of hardcoded ones

Also, I would point out few more general issues:

- compat handling is is busted for the normal syscalls, and only
  seems to work by accident on the time32 one.
- the time32 syscall passes a kernel structure through a __user
  pointer
- this is the first patch (or public email) ever sent by the "author"
- the changelog text and subject line make no sense whatsoever
- four submissions of the series in three days, with the latest
  one labeled 'V5'.

I don't normally dismiss new submissions easily, but I think it's
safe to ignore this one.

  Arnd 
