Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532047;
	b=uCXf6mnxzyXZlHJG+VvFU3BfLAAe+QOfGYTD1yBggYizHs0WVNT7oWhYfr7b0W/rU/r+
	 cAH1LHh7csKHobcwA9uj19D9o7eKK5eOFKTkShM59yfeYCmpX/CSrOt/vG1KQDq73/UQ6
	 RwRyn824GWaMdiVNBdXo91Tlewo+0LSv/BCpJQtot5ScCBnD7LVnZg/XWDojo7XHe+q7N
	 huXIdtW8wm1iPI6oo/OS+SgWPS1fMi+StZbvl7j29Sp6NfdbBBcJf3sKh+CM6QKeTax3Z
	 F3BV57ONEQHN8Z24xgCZ9N5X1tR4WD8nMWYLzTS/BsNfeq/bZ8JjeUi2dbYt6XNMYnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=72rQE8Og3nCRl/elXTbQpPdCGc/X7s6eyv03c5TXm1E=;
	b=x8e7hClzrKr6iXE70NbLOhszTbubYsEfmVcKC3HMaLDeGZotvIA+jiiNXxBp6+t5L8i5
	 tukxrqSihrLQxXs8FZAEjCM/ItSQxzg5MbKL8SjqxSAer3H7yNS6ETyK/AR1f10IcS2gv
	 N/JZwzIJ4n4u1ssBemeh/qUBpksLSFn8KKfI/2SUelAkhqDHgcpNHpAjMWsgA5kCFtPVt
	 rwhsZjSFhmTZXP1LUS7zGQ+VJDwA2Y1lrNme7NA8Q/rMinkiejOGb/r7oul4KFw4Clb+8
	 tdOqFLKha954HA1v5eYIy/a8VzCcK/ZLhYFANznbG4glxQ00ufBvdXBBv8/7WlumzpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OQUlPy0v;
	arc=none smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F303860A2619
	for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2026 01:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F303860A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OQUlPy0v
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3acef9307c7so4326341fa.2
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 17:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794532045; x=1795136845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=72rQE8Og3nCRl/elXTbQpPdCGc/X7s6eyv03c5TXm1E=;
        b=OQUlPy0vx6CcGtdaEoC4ZzAuJLpXkM4wlajkcs2qP58X6urrCnT+8Q7NTXhGc8mYzw
         d7tN7w4oKGzDmItizvzN7jmbjEUoxvzdJ9i+lzNGmeNbCP1SfPyIbecGvC504TniEeUk
         kbHdc69GU/DGY2StNsJ8myojUrFbAY8habOBxDCdA1SilNVUBiU5vl0gHe+c3m4oqw/N
         nD8QLbOWody2KuLcnH9N5b93zFUeu0lDsCQaepZ8dFqKdguKTO/AMJVmBcHsGgOClojK
         4ecHNMUf+4x+3Dml/FxOIF2msdb7vPtjyUCgcn12XcPTbX/UDjY82NBQsaEp0LcwD1sr
         HVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794532045; x=1795136845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=72rQE8Og3nCRl/elXTbQpPdCGc/X7s6eyv03c5TXm1E=;
        b=HiTXLKNJuLTQMZkLVStjS82L8G1alKtngoVXrcCmHARNH16Hz36W8dIERI8Os0LR1I
         WwgIdmW4N0lPnrgq6MkQyLFzWSufo9OADLrdQqLS2wSdapu2uFngqVqiRHlvcUmojjSV
         zy2ymkPlMUDM0YHXITq49NFa5TYFOwrvUIvvAvuXlvnUUGfi6PiZFOjHKKs7Zu9etAWX
         E/Y+GIg6Zc9elmwlZnshoCOtvipSnHPlQOk42EQu75Rm9MHITe0BH+5+D05FJUFF8N4J
         M71jqbION0//yJLfly6h/ieuUfVZmZ0bRDyW+M7T9/7cCzYuEKpHRd2rRpR5cmuZ+HUP
         lbrg==
X-Forwarded-Encrypted: i=1; AL+hErFImNihoMFS/vaNKTCU8Hk9jaQ9+URsNFppYo9cPaUEXUP9DPC3pKvKZY5/GhEt3pFk77vmWMyIx9NY@vger.kernel.org
X-Gm-Message-State: APuU4Z+lWLUkrk7O+sR++MQkOnwXaW42yUmSyJNfo9bgChD1p3E3mQ0u
	cNPcx0QWk5/bYrw6KPytZUZxMPt13KEzkwIE5TTHxb37cHgw2DPBbNHu3hLjV+bhgJ8=
X-Gm-Gg: AYBFou3ytMv85+pr0zOrEHpC8J97Ziy2I1I9H6vORLj6wc3FpUDz1dXUCmvcmcbSXv9
	JHRu+ta6mLVhrZdcVXZfMFKw1/iMixKILnEtLD4wdtkIXzI9ZyC0WXzr/lUapYGtVO/0FvSJUjV
	dItyDyo8niYFwf9lAPrDmIOTszlSROCdOgoo3yViWFLEl6NmwgEKJq4DhgZMkteQmHp026uwRRC
	P+ow70N3/SoWhjd6z9bY9sgAgX6LtHmN46ifyNelIJR2bQqMd3U6MUiQxWwEw0SGMZF9ijkE9+s
	XrL2UatIPFSxr0t9JBZmbbtobnwVcveORa5vVP7kVlRlVppR624tjd8h0sZI2P5vdTd16VAgk8m
	SUJpo7ETIiPRY8VK9EFeQpSa7UttZvwST8cpN9HTk2mpC9Q6rk6szDEbpMGs4ErjOgrXjfqOTJZ
	drWaHb3RheCu2rwR2lHCxVpNZUFuQgB6dG2PMbz6MJsPKiVcT7wcVVAcrV4RhGYLS0h4lXpgN1W
	zDqmv+3TKbOM+CuDPJ35LxhIi09hJfWek04acbcBqZ7ACmaWFVCF05r1foHipBZaZRK3ICsdAaX
	mRJLRz4+kwL5WvX/7/4NB9XP4SC2bVac6c1TpsMUh4MnZo4Wm9B1aqbxQWWAKPhzaR35PHcHLB5
	eX2/+bdY8Ow==
X-Received: by 2002:a2e:a105:0:b0:3ac:f350:cd66 with SMTP id 38308e7fff4ca-3ae2b522034mr3240131fa.20.1794532045076;
        Thu, 12 Nov 2026 17:07:25 -0800 (PST)
Received: from SafoStation ([31.40.65.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae2b7d183bsm3133941fa.31.2026.11.12.17.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 17:07:23 -0800 (PST)
From: Safocl Stollmannovic <safocl88@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v2 09/10] sched/preempt: fix duplicate extern declarations
Date: Fri, 13 Nov 2026 05:06:14 +0400
Message-ID: <20261113010631.139191-10-safocl88@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113010631.139191-1-safocl88@gmail.com>
References: <20261113010631.139191-1-safocl88@gmail.com>
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

Compiling a kernel module with a C++ compiler results in a "duplicate
extern specifier" error.
This occurs because the code contains `extern asmlinkage`, and `asmlinkage`
expands to `extern C` when processed by a C++ compiler.
Since the code already contains sections that respond to a C++ compiler,
I believe it is a perfectly valid approach to gradually move toward a state
where kernel modules can be compiled by a C++ compiler without any issues.
The `extern` specifier must be removed.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=222257

Signed-off-by: Safocl Stollmannovic <safocl88@gmail.com>
---
 include/asm-generic/preempt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index 1adddeab8..fc0da591d 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -93,8 +93,8 @@ static __always_inline bool should_resched(int preempt_offset)
 }
 
 #ifdef CONFIG_PREEMPTION
-extern asmlinkage void preempt_schedule(void);
-extern asmlinkage void preempt_schedule_notrace(void);
+asmlinkage void preempt_schedule(void);
+asmlinkage void preempt_schedule_notrace(void);
 
 #define __preempt_schedule() preempt_schedule()
 #define __preempt_schedule_notrace() preempt_schedule_notrace()
-- 
2.56.1

