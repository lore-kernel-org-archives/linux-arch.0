Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D0D3D5C0C;
	Tue,  2 Jun 2026 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398772; cv=none; b=qgLH/i0NL+XBarjIdlPH26etRAHkrP97UHzrntyNLC5oncKOTQ56u/Hbit3C/yGw9AbsgyVFMGhiI55krm/VUZnxlSpn+XtA1kgPr3Mi4fTcsONTYM5FXCuVeFZAWL0TeyGqQRRos1uey/2Xu3ctT2FX1EqBBx/eTvY28KbbfUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398772; c=relaxed/simple;
	bh=vvILlsXaVQShutp1p5WceQi2Eaf3pB4ovG/S15HHsU4=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=cNHkPHmtouJJRpCZK+UhcqWNnVG5Lnj/ejJkkyBb5FzLTOY4+tGJEfbHDPiD/c+8vGwiYeHAUgNjc0CC3//sCAJFkNx0uwE8zfSpNt6jFeXySlJHlHrdViH9FrHGsc9zhd0iiVVL9o91EUAYtQCKiwa1XB3bZ3PFo73l6liDFYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; dkim=pass (1024-bit key) header.d=xmission.com header.i=@xmission.com header.b=PT1nwI4K; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xmission.com header.i=@xmission.com header.b="PT1nwI4K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=xmission.com;
	 s=xmission; h=Subject:Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vvILlsXaVQShutp1p5WceQi2Eaf3pB4ovG/S15HHsU4=; b=PT1nwI4K/LueK0DDSNL+s4C13J
	wCISW9cQ6Rku1p5e71v6LNcH9E8BpNOErgTq20OxsIi/JohdQWrgMebuwQrMKgen7pJXROs+AsRqv
	q/PDtUrCrIsMZAHrVRiLpwUsOkpysGxuDIlQz4e1uDX5u9eweqgYZDbb9a8545EZNJqI=;
Received: from in01.mta.xmission.com ([166.70.13.51]:57296)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1wUMHI-00EQUk-Sf; Tue, 02 Jun 2026 04:23:20 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:37600 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1wUMHF-002RRp-JI; Tue, 02 Jun 2026 04:23:20 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Deepak Gupta <debug@rivosinc.com>,  Deepak Gupta via B4 Relay
 <devnull+debug.rivosinc.com@kernel.org>,  Thomas Gleixner
 <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,  Borislav Petkov
 <bp@alien8.de>,  Dave Hansen <dave.hansen@linux.intel.com>,
  x86@kernel.org,  "H. Peter Anvin" <hpa@zytor.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  "Liam R. Howlett" <Liam.Howlett@oracle.com>,
  Vlastimil Babka <vbabka@suse.cz>,  Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>,  Paul Walmsley <paul.walmsley@sifive.com>,
  Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou <aou@eecs.berkeley.edu>,
  Conor Dooley <conor@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,
  Christian Brauner <brauner@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Oleg Nesterov <oleg@redhat.com>,  Kees Cook
 <kees@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,  Shuah Khan
 <shuah@kernel.org>,  Jann Horn <jannh@google.com>,  Conor Dooley
 <conor+dt@kernel.org>,  Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor
 <alex.gaynor@gmail.com>,  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Andreas
 Hindborg <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,
  Trevor Gross <tmgross@umich.edu>,  Benno Lossin <lossin@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-mm@kvack.org,  linux-riscv@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-arch@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  alistair.francis@wdc.com,  richard.henderson@linaro.org,
  jim.shu@sifive.com,  andybnac@gmail.com,  kito.cheng@sifive.com,
  charlie@rivosinc.com,  atishp@rivosinc.com,  evan@rivosinc.com,
  cleger@rivosinc.com,  alexghiti@rivosinc.com,  samitolvanen@google.com,
  broonie@kernel.org,  rick.p.edgecombe@intel.com,
  rust-for-linux@vger.kernel.org,  Zong Li <zong.li@sifive.com>
In-Reply-To: <87wlwif04z.fsf@igel.home> (Andreas Schwab's message of "Mon, 01
	Jun 2026 22:58:52 +0200")
References: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
	<20251112-v5_user_cfi_series-v23-6-b55691eacf4f@rivosinc.com>
	<87jyslndo4.fsf@igel.home>
	<CAKC1njS=AHu6uHrH4ae8VxcdEbhgiPXYCAoN3F_mnppBd3SwOA@mail.gmail.com>
	<875x44o9hj.fsf@igel.home>
	<CAKC1njSn_rtCj8ii876PNQTk0nsCTfWsb4DzdymufHVthh1Rkg@mail.gmail.com>
	<871peqgp9v.fsf@igel.home>
	<CAKC1njR+dTdvp+BmLGPtgd8dufiUwBtkQ9a-qinELT_Fmi13sQ@mail.gmail.com>
	<87wlwif04z.fsf@igel.home>
Date: Tue, 02 Jun 2026 05:23:10 -0500
Message-ID: <87tsrli6lt.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1wUMHF-002RRp-JI;;;mid=<87tsrli6lt.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19J6tpF2AGRJ9xglxGPNzSSZeVg13KZsgY=
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4997]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Andreas Schwab <schwab@linux-m68k.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2774 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 3.6 (0.1%), b_tie_ro: 2.5 (0.1%), parse: 0.84
	(0.0%), extract_message_metadata: 8 (0.3%), get_uri_detail_list: 0.86
	(0.0%), tests_pri_-2000: 7 (0.3%), tests_pri_-1000: 8 (0.3%),
	tests_pri_-950: 1.02 (0.0%), tests_pri_-900: 0.92 (0.0%),
	tests_pri_-90: 62 (2.2%), check_bayes: 61 (2.2%), b_tokenize: 13
	(0.5%), b_tok_get_all: 9 (0.3%), b_comp_prob: 1.76 (0.1%),
	b_tok_touch_all: 35 (1.3%), b_finish: 0.56 (0.0%), tests_pri_0: 297
	(10.7%), check_dkim_signature: 0.41 (0.0%), check_dkim_adsp: 3.2
	(0.1%), poll_dns_idle: 2367 (85.3%), tests_pri_10: 2.7 (0.1%),
	tests_pri_500: 2379 (85.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v23 06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ
 | VM_WRITE
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: too long (recipient list exceeded maximum allowed size of 512 bytes)
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Jun 01 2026, Deepak Gupta wrote:
>
>> riscv uses `VM_SHADOW_STACK`. It's just very simple to use `protection_map`
>> with just `VM_WRITE`. On RISC-V, `-W-` is a shadow stack mapping. It's not same
>> on x86 or arm64. So `protection_map[VM_WRITE]` simply picks shadow stack
>> encoding. We just ensure that PROT_WRITE is converted to
>> "VM_READ | VM_WRITE" at vma level.
>
> That does not explain _why_ you need to make that user visible change,
> when others can get away without it.

Especially since as I recall the decision was made was that the user
visible protection bits would match the mmap call.  If there is some
combination an architecture does not support that would simply not be
reflected in hardware until some future version of the hardware gets
around to supporting it.

This is what happened with executable page permissions on x86 for
example.  It used to be that it was not possible to deny execute
permission on a readable page.  Later that proved sufficiently valuable
that support for denying execute permission was added to the hardware.

That all happened quite transparently to userspace, that wasn't trying
to assuming PROT_READ implied PROT_EXEC.

So I am at a complete loss why someone would choose to break userspace
by confusing hardware limitations with what userspace asks for in mmap.

Eric

