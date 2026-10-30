Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384639;
	b=DosHTtuBDY8Drj5YyFo4Cn9LQ7+NNDlMKdyMxfl1ByjdizaLneu7Ld5IggCjuKRzGduF
	 eTS2xFuf68i/2/nHzXigpnYGNm+RPyShAgf3zyGiE3wz7ALs+Gm8efsumv8oviuzsVjLW
	 3NGyK0yDUXWaJ69ELgGuTLv0MHhcTCis2ExxdyOr0fdgPcQi5D/EXDq3NEloYq6qu2mGd
	 MOGO8vIpTanC9dWWBAF+PJJ9EpUGSY0ZDwcHNDAX6MTXKwbchciQe/+YYQ21QEoM2tSLY
	 6A+AlWE4pQ+ysaY+Z3yCU72RpIVW4h/msWIqlyGdHGTprOcRVFeRP+A/HMOS4NZ0wBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384639;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=st/TkA6CBLvuYEqwa+4bf7yeukWH3Bzp53kbH1Y4OCQ=;
	b=bviXb5/eGrMM5AHK4mgq3AkHj+jgT/vPlh4/YN+ye4gucUrwbFuQ9iWA9WwveVMURXjg
	 4kj8pk8S9SPWMvAH9wTf7B5+1fiMEi9qlZ0hQk1f4eLg/E7BdylbOOByx/3uU13WBvR93
	 7PUYHZr8Mwzdo/7alGP610H55QUyOi/W+zyl0rgcsg22PiEBr/nQ8j1FBf5AiOttQhEPc
	 M8fxgDqZIebTfPvLrfRSkiq0qhnysu4qGZVppmLfk9SxlgxsQZ8iIKf4JioP5TDt32dKb
	 +ubTzgaNGj/bhQtLwec3FD6dGGAKSPUjjLhosE+wWt3c/DGQVE2wFlM1+da9FgMw1cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=jm0TEPUQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YcZlobTd;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1C606A31D
	for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2026 18:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82D1C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=jm0TEPUQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YcZlobTd
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A4B714001CB
	for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2026 14:23:57 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 30 Oct 2026 14:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793384634;
	 x=1793471034; bh=st/TkA6CBLvuYEqwa+4bf7yeukWH3Bzp53kbH1Y4OCQ=; b=
	jm0TEPUQIa3Is3BgMXlrBATE52PsQRU58rWlFIzdzO63kLG3qDoJ+OtDHCltsabb
	pJt/+qXt28Vk+hUNWYtUcfZ5tR6npQwJAKWcYIOk+CcD1H5k2URXrJ7kehR/QsEX
	etnNm71UY5KRhYOki5V1Yk2H5JgDsImUqkcO6WxPCYmrkjGTsUeyYhSyysG1ktom
	R+EKgmncReTBsDX8XJCURkEECNNbPxtzYh8tjNvh0pGqCLAv33EDeXq03A+JtoEr
	poGGPySKBvBGHo5YRb3qhrD4vgXDHIsKenBWWoifZI0jQOFrcjmEBTTocoBEQoFd
	iYo1d4CBCvXB94WQ/fKMrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793384634; x=
	1793471034; bh=st/TkA6CBLvuYEqwa+4bf7yeukWH3Bzp53kbH1Y4OCQ=; b=Y
	cZlobTdKjuNElX0tkSAggn098DsNOfBfR+8bi5YyVYFg6wBxkrTAs2725dqx0dhJ
	CdI4P12n1xXNGQqzpAwJozzp51zq3/S5cAqZk2IJHKCbpJnJ17K/3l8l0uan4Mdf
	j6fOuDJmV7sCbcSAiZObjIavAi5YABidWMzAyoii+YXl7Pttb2jvybccUYG0I2xz
	VDYgDXQLTQw8/IET1moAJsXAh4F8H91AxdLIwmkJJAfZS4CYqnUArF6DLXVbBZtp
	9WwKjQPs/1rdqSq/KnAhbBV+yPs7Yg6zymU/pJiIBy8nR52Y0kW0WVPjkK8EvOj2
	q5rRqa7M1eFsNmf6KpK3g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793384634; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:AuKHTkjFHXlSEaPAZe2ouxrMH9Q9SplKTkhpK4wHc4SjaKJ
	WO1r6rHUgsaihsikoWTUjjmo99W905pY9NUNXg7/RqL0A8ZKdsQ8sEJV70xb+33Y
	9H9OgsEnZazdjup0o9rBa6lTuM5Q0UiThxQn2Z/rKa1AzcURAjM1kVgI6dq8qvW7
	KiwVFOVlXr7ClOZohCr8WiMB/2xNlEXlKYWMnohjgvbs5+vF0U1l8fNYRkQnJIXU
	ZgZkGQtFS6L5CaEYv7aNYOJ2UVb4mbRMnfqplSRCk2sB+OlWV5SqSxMLirKYhQTz
	xc6JAbNL0NWTP1c55KT3P2MIbW9JLrtjWZPRwDA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wSTNAuUov5ELYxK0Ezwh6wKOfN1DQCJ+buHooUAknuc=:CJjo0U4Q4WipuJBG6WDA4qv8EpzWNDrOCQwbutjeOgQ=;
X-ME-Sender: <xms:tuDkalg5ZRqDYu6TWRpgvkK9dTxe188VEl0lyRyOzuugVATS07YKVw>
    <xme:tuDkak1OTTe-thO_El-oboLsYAufoeCICCOA4tRRc8jJ4DqMdINbNKjF0bSxqrIS6
    nUibdeNxGRYMWK96raI8lyL9Iu2Pem4R_x8pVIlz0vNheSdby_x1qNz9Q>
X-ME-Proxy-Cause: dmFkZTFHz7yaXqSibdqx0TXzdAIv9WG31ARUUtQAsNvw3trTKkJqvMEcJ72/EEKZAETlDx
    B8XezTsJEEgkSNUEH6sTEwEUQY29QcGCn6EqKcwtbz7Hccm9w/NKrSnV6hk2ZAhFVqnYPQ
    8SWdIEFk1RqHQ9W1BzlC2nlkkQHrvZk0S8w/lGu5hyRZwAiQxkGfkWY330qwlJT0lTsdG3
    FJqJvp7ipBAyeadxFYwqHPjZjWRAB9Xc06qu7irEKi0Q3Q6LNvSo09cTbl8lEgTLNy4ThB
    mm/UyDCay8VFVAD5XvcCGfV698AjsSv8MRF8+0tU8JR14nMcum6I2G6Bn10615A7V2nua8
    WZ/YCnl2ayBV2cYjs0wdXacltDpXtAcmdmd/UA97Ht+nVV4z7Jhp3Q9DzHEbMxOkorcDyG
    1qY59pVi9/HruJvrqaFrcdtBWkcZS1r0GePa+W1uk2G4A1kiO4nmcEXz1bjw2tvQiHPiit
    MWKgMpx0jpelg01eC8+JgsSAmS2+9aHMamWmCpbvVxyJNOcBGlZAJ9JNJob1DsOt4egY61
    1KnPCelHqk7eIxNRz19yqqh0kTY7t1P/l3eKyAnWEQhFOKbJhImP4vQW5b7f7VCchH7I6R
    JgUWN/xJud6iPJRxqvef92bseDiQ/MbVW7Rvg+Ckc8vXPzat6x7U+G3W2lPA
X-ME-Proxy: <xmx:uODkagT3CaKHEJxKHGQjco2NhaWl30vt-vC337p6DzsZIKJ6lCu5OA>
    <xmx:uODkagWlj1Q6rC2PWZCKeysISPjZmXwvR-ymcbYMhORmofh_fYC-IQ>
    <xmx:uODkaheWJQ31OQoK5BQ_WqsEr2yU3-2o2WAkBPkYSmRCyGrxW-gsHg>
    <xmx:uODkakJHmrpijvuzft31wRhLIVws9KWJYsSpF_3x7vNCauvlcSmK0A>
    <xmx:uuDkapaq4uwX8LmqERqamOWFCuD6L9Ogr5tQyB6y2jycqot7bnShvde9>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 60F7E32A0093; Fri, 30 Oct 2026 14:23:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AA4M8BakChSJ
Date: Fri, 30 Oct 2026 19:23:30 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Huth" <thuth@redhat.com>, "kernel test robot" <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
 shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Message-Id: <5f898f0f-915c-4aef-a3f9-0118f4539951@app.fastmail.com>
In-Reply-To: <cdf09fa3-e251-4d8d-9f0a-316998df036b@redhat.com>
References: <202610291918.kHO0GTDB-lkp@intel.com>
 <9e294bfd-4704-42a5-a704-f301f4afe042@app.fastmail.com>
 <cdf09fa3-e251-4d8d-9f0a-316998df036b@redhat.com>
Subject: Re: [arnd-asm-generic:asm-generic 15/15]
 /usr/aarch64-linux-gnu/include/linux/types.h:12: Error: unknown mnemonic
 `typedef' -- `typedef __signed__ __int128 __s128
 __attribute__((aligned(16)))'
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 30, 2026, at 18:46, Thomas Huth wrote:
> On 29/10/2026 23.13, Arnd Bergmann wrote:
>> On Thu, Oct 29, 2026, at 19:09, kernel test robot wrote:

>> and looking at the preprocessed file, I see a wild mix of tools/include,
>> ${srctree}/arch/arm64/include/ and /usr/include. I also see that at least
>> part of the problem is that arch/arm64/kernel/vdso/vgetrandom-chacha.S
>> includes arch/arm64/include/asm/assembler.h, which then goes on to include
>> the world.
> After getting access to an aarch64 host, I was finally able to reproduce the 
> problem. I think it's likely best if we force the selftest to use the 
> headers from the current kernel sources instead of using the headers from
> /usr/include ... i.e. this patch fixes the issue for me:
>
>   https://lore.kernel.org/lkml/20261030174323.370687-1-thuth@redhat.com/
>
> WDYT?

The idea sounds right, but it doesn't appear to do anything for me,
I still get the same output:

arnd@studio:~/arm-soc/asm-generic$ make O=../build/tmp/ ARCH=arm64 -C tools/testing/selftests/vDSO/ V=1
make: Entering directory '/home/arnd/arm-soc/asm-generic/tools/testing/selftests/vDSO'
gcc -std=gnu99 -O2 -Wall -Wstrict-prototypes -D_GNU_SOURCE= -I/home/arnd/arm-soc/asm-generic/tools/testing/selftests/../../../tools/testing/selftests -isystem /home/arnd/arm-soc/asm-generic/tools/testing/selftests/../../../usr/include -idirafter /home/arnd/arm-soc/asm-generic/tools/testing/selftests/../../../tools/include -idirafter /home/arnd/arm-soc/asm-generic/tools/testing/selftests/../../../tools/include/generated -idirafter /home/arnd/arm-soc/asm-generic/tools/testing/selftests/../../../arch/arm64/include -idirafter /home/arnd/arm-soc/asm-generic/tools/testing/selftests/../../../include -Wa,--noexecstack    vdso_test_chacha.c vgetrandom-chacha.S  -o /home/arnd/arm-soc/asm-generic/tools/testing/selftests/vDSO/vdso_test_chacha
/tmp/ccKJRkeX.s: Assembler messages:
/usr/include/asm-generic/int-ll64.h:20: Error: unknown mnemonic `typedef' -- `typedef __signed__ char __s8'
/usr/include/asm-generic/int-ll64.h:21: Error: unknown mnemonic `typedef' -- `typedef unsigned char __u8'
/usr/include/asm-generic/int-ll64.h:23: Error: unknown mnemonic `typedef' -- `typedef __signed__ short __s16'

It looks like tools/testing/selftests/ is built in the source directory,
while the 'make headers_install' installed the headers to the object
directory in '../build/tmp/usr/include/'.

I have never been able to figure out how kselftest actually wants
to handle this.

      Arnd
