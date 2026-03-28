Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4535DA6E
	for <linux-arch@vger.kernel.org>; Sat, 28 Mar 2026 02:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774666021; cv=none; b=iTbGsXm48XWepckwoAq2Ouk9JLTAnzSREChHu8IDtsMH1HtdfDOhsqhtdQHiwJD5wmqXcHAKXqdLTj9GEL1Gn0zcf59cOJegqgTPLXISg9LACgWkkkdQ6wMUzAfWDHiaLVE1IAsqFkcEEYr43WrKqJfWDAL5xUqL/ZSgvKDK3zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774666021; c=relaxed/simple;
	bh=uEiCHIBcdP0KnUpUEy49LkM4KR3L9faV/Smhe9u32jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4eX3fD048qbNPwNh2T4fQoDNt6NBGxJ8GvU253zCo93b6X3TbUG0OcRDtjSo42bbr9LBq6FMzx9eQXydeLPIBiiGdTERFhhxHgzePliphGOvqBtN6ZqRq2r/q2vxaDT1Ooj5/6oEV2IEUZh6+0/3qUxKYQ9ZkRgUvC1oUMBgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=MQwZz5E0; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="MQwZz5E0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774666012; x=1775270812; i=deller@gmx.de;
	bh=uEiCHIBcdP0KnUpUEy49LkM4KR3L9faV/Smhe9u32jQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MQwZz5E0SEgdjlyn+VYAYjJONJ3netcTiQClZTCkewx02/qTSsPsDd6ifTjRrM+H
	 mtpMXVvRwSmijUMkvKlc9pqCOGVjume9eguMWo1BrixS6R2p9QEqfSXYm7gT00Ki/
	 tRGoF3AQaxaqZpviy7jEPLkpze7bxlZ19uCwUeNhp25Z5/SFP88L+40BjZhPaAfpi
	 fJ08mTsQna3G3f0QRifWY9Bz/1PAlfwzlHYzEEDoBEqaL9o1JLWo0SWMN4ev82qQD
	 cqfzAF8bCGwnSpCx2RPVcyzvZFBrDAqTRx+SWnsgtnzPv0o1Raxdcpg1iyM8n3cMC
	 auIqW4HfGFtuPTdFgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1ML9yc-1vo6MD3giA-00TaI8; Sat, 28
 Mar 2026 03:46:51 +0100
Message-ID: <57e3e7e6-f120-422a-bac1-a11f0e4e7919@gmx.de>
Date: Sat, 28 Mar 2026 03:46:50 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Attempting to unify some user space copying APIs
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux-Arch <linux-arch@vger.kernel.org>
Cc: Russell King <rmk@armlinux.org.uk>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Helge Deller <deller@kernel.org>,
 Huacai Chen <chenhuacai@loongson.cn>, Will Deacon <will@kernel.org>
References: <CAHk-=wgg1QVWNWG-UCFo1hx0zqrPnB3qhPzUTrWNft+MtXQXig@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAHk-=wgg1QVWNWG-UCFo1hx0zqrPnB3qhPzUTrWNft+MtXQXig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OjuMRMZUj9maV71Rfmtvs3c/RgAqyFODZkkNt8DxzGovDSgL1R3
 SWgA3wP4+USIRWiCcyg2bzO1adp+ENF2ncS/KqETGifDByxg3W8PjOURlXYSzcB0lwPYQim
 CdNolD1NURRgktstrFZjETR1lLuhga9ep07bmJhAZE3sma3M5xvRLB+swJMkTbV/6i/hgEz
 e6nzUBirpNLWRTx8lEDOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ert2Y243srE=;CtaAfes2ad5IJj3g+89ckgFgJN8
 ++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

On 3/28/26 01:20, Linus Torvalds wrote:
> I'm sending this out to the architecture maintainer list (and a random
> collection of arch maintainers that I just took from "recent pull
> requests") in the hope that people can test this on platforms that I'm
> too incompetent to check myself (read: I haven't installed all the
> cross-compiler environments).

Successfully compile- and run-tested on 32- & 64bit parisc.
Patch works as-is.

Helge
