Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013522;
	b=MtcHW8XXpcJ6n+MpCL1ORmzpXcrX2k1jGKp+quDAv7+1jO4hohHRaMQ2QsFW/oLJi/b0
	 +XdugBYTit68NUKBcqJtIrHJHZK8oyPcsQIbQTgHV44j3FPfRAMzHwrLI7RPpL804bSDa
	 T3W+HksigT1dar4ZiksKn3GTJ8onJZdSr+txJ7U6hJT3r1ULYHk6uywynrQK+p20wk245
	 SVOj9iekEkn9HQ2s7DJzcBoA7lF4UAO43V9HSlD6mmT8hAHEoxhKUPW83QjgfmkYLtQ99
	 cAS5+vppSi3TbP9DhgaQIPUFOiia1YNcSim0kZRysu9EXMaGn/QPjQEf88UtnDFRIew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013522;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=b+DCJkrwcuXKWzPX0QxpX1ccVGXrsTMiQkeEh3cGqxQ=;
	b=BTG1F0b9oW4p4u9fGVXlfiVk7FncEUzmhvzqyY0oY6FuHlhscwibTyHd80k2VP94bCho
	 dNRULzI/qyAZOdw84NEHuCMrZeG8N3unQg8sjvwOhwZzlK5ry2fWg9bjwkkoV8qBqLwx8
	 OR8qGCyBVKXnQzajwwdjxLy/EBgaXU+o+26848+X/g6MRakU3oqAfanVg1V45xsyRQKo5
	 hWBv6uG1BFaBVIu5HVQbDweUfxayyHob4w3BFWATPeJ2hz/XHKTTQcAF+/HcGAgwqjhyR
	 hIjcrv5/xBCjCfWuGQ+63eXUUddgqs5KT531bxoUcV8OKMOp60beLSg+mVxdIvZiQMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hA5pWdDm;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB8606A327
	for <linux-arch@vger.kernel.org>; Mon, 26 Oct 2026 11:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ABB8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hA5pWdDm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b+DCJkrwcuXKWzPX0QxpX1ccVGXrsTMiQkeEh3cGqxQ=;
	b=hA5pWdDmKdBq0szN8RZCc7Gwv6bvknCrB+9rVITrdTGJmPSf20aWiUrd0cFsazFpou4oP2
	zCQwOl4mQ45b9lVy4RI4dZLuFlgJMmE91h8QtoZyQaB+VxneutABgIoyqvl5Lkz3GnLOlD
	rfbmYb98axTvTeqhMCZ1wBrS8u7G5Y8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-w4DS_Q8MPOSm-ovV3-ggYQ-1; Mon,
 26 Oct 2026 07:18:35 -0400
X-MC-Unique: w4DS_Q8MPOSm-ovV3-ggYQ-1
X-Mimecast-MFC-AGG-ID: w4DS_Q8MPOSm-ovV3-ggYQ_1793013512
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DF8318001D1;
	Mon, 26 Oct 2026 11:18:30 +0000 (UTC)
Received: from jmarchan-thinkpadx1carbongen9.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3665D1956087;
	Mon, 26 Oct 2026 11:18:23 +0000 (UTC)
From: Jerome Marchand <jmarchan@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arch@vger.kernel.org,
	Jerome Marchand <jmarchan@redhat.com>
Subject: [PATCH 0/7] Remove the unused non-atomic local_t and local_64t functions
Date: Mon, 26 Oct 2026 12:18:15 +0100
Message-ID: <20261026111822.458404-1-jmarchan@redhat.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

While working on a fix for a tracing soft lockup , it came to my
attention that __local_dec() was broken on ppc64 and other arches (it
actually increment the value). My first instinct was to fix it but the
fact that this function was utterly broken for so long, decades for
some arches makes me thing that those functions have not been used for
a long time, if ever.

At any rate, they're not used now, so it's probably better to remove
them.

The local64_t don't have broken arch specific versions, but aren't
used either, so remove them too.

Jerome Marchand (7):
  alpha: Remove the unused non-atomic local_t functions
  loongarch: Remove the unused non-atomic local_t functions
  mips: Remove the unused non-atomic local_t functions
  powerpc: Remove the unused non-atomic local_t functions
  x86: Remove the unused non-atomic local_t functions
  asm-generic: Remove the unused non-atomic local_t functions
  asm-generic: Remove the unused non-atomic local64_t functions

 arch/alpha/include/asm/local.h     |  6 ------
 arch/loongarch/include/asm/local.h | 10 ----------
 arch/mips/include/asm/local.h      | 10 ----------
 arch/powerpc/include/asm/local.h   | 10 ----------
 arch/x86/include/asm/local.h       |  9 ---------
 include/asm-generic/local.h        |  7 -------
 include/asm-generic/local64.h      | 14 --------------
 7 files changed, 66 deletions(-)

-- 
2.56.0

