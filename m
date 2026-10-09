Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F9438E8B2
	for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2026 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534158; cv=none; b=MYQff4hxHQ0pOyxTGLmAX4AEhf3s93WeblJPzESWSZHRdYc6sxzYbs4rndNOxXv41MBlQpLHlxDtdpNMsbYcTsvC0PtC5+2bd3rEsbqnN1Eyx/JI/n5DNepVrN5H4Ma+BAcWSJzbmYIgpSnTqUlVT5/rpZX/k34zi+gsj0oDIt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534158; c=relaxed/simple;
	bh=AmPAlSohTFt+K5YyTCswin1xWvttAea2QIBo3K30gng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nn/ZMmRG3i36GjdWN4ESwLGsBYm6jNwapPDFyI6pVTO3gCenJxE/Gsw5olgxOhSmM+i5YBlSEKsGtjHpuHKKcwx8maz+C6qqTZoCS9sU5/FEpBDDpN1K0vfJCv9YPwY4gEVB7mTfjXshKbfG7hIbtQ320euAKOrDCFBIT5ehaNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rOG/ZhkU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOG/ZhkU"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a166199820so9170085e9.1
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2026 01:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791534155; x=1792138955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iqp5RhRnr40+lLsW/0GeJg1Yf3xCkEgMP6LPH/ArdaU=;
        b=rOG/ZhkU4oOyLTTAtP90Co11VMBO3yb/spQqiuq472jhOjv2p6CghfHOkc9XOQ9Lk8
         67da4ZRIYYeYxPMaq0UMe60TzHhFbN5N5ZKJXkXXmnZZ+bw8DSvB0j2+GaJZcN8sPvPc
         SEM7TlltOwhOOwEoQ/Ktu6LNHLyOUQgZ/cAbyjGT3LXN4/8D7nbL7ur06374fTVVJhyF
         IeH/WF/o7KKpGERPtaKhaSzHzYoWnQsB12xCfE57vg3k07iAWjpe3mAB34GmvWZlJ6zm
         lzIHeazWM5smlM0s1WwusvCOkHvwOMuYzblZanDpwpbv/gHisznfDVAUA9TcNXWzpSrg
         Ny3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534155; x=1792138955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iqp5RhRnr40+lLsW/0GeJg1Yf3xCkEgMP6LPH/ArdaU=;
        b=kgMPl6kf1Ng7gWvI28Bmv8fmthyeNEx+a/O2HntwzZxip0hP2TSsQLV9ALd5awxpYv
         djJDFAM52VC5wVDnsAgXHXWXSZUSz2TkSn5a7ZCa6iXjmRjiIy/kVaWFLlsSdfsfv4r0
         g5+cfYgp4rWL0Ek0EkGuNSMjH/RVNXcngUN7byQuj97dZnuxi6xyzBbI6cdbqvh8E93Q
         3a3RJ8R+JDzC0DZk5cawvD0WRAkatGlEdIyc1EzD/3gA782C/DLCu+N1xjW2qiljl9Tt
         wn+mzGAsfAvaWPerdfm43B3b2pwTrDiFEmthV7p15HKL4KMwWnglrIxoiQS6Kg+/6IwM
         zO+g==
X-Forwarded-Encrypted: i=1; AKwUvBz3BIHkuS7zD3LwXZnrghT6bED42m9R07sIyxBHEpgvUP7cNUhpB3V9cAPULzYhy6Nq2dejEcaVJnCy@vger.kernel.org
X-Gm-Message-State: AFuF++kBKPMHIcQ5iY30UQzFiip/9tJdfcJGUT5eUm/INGx4WiEM9kKA
	BZq8vjRDfjMJXvYD7t5bTP1QooKGuO3CtrG7tKFnkJW1SJCDvPmi3M+Q
X-Gm-Gg: AYBFou1Y+p9GB+mgO/XfOiBuhg/C+D7VFkeRzJQALK9x2xKoDaGz4DLKOX+POO0yifQ
	FF3ncvhWFFbOBehWqXiKEHZeAr7k+YWN3wuP/z9qAxahAB5vww7EJK/5vsuew6P+IYzagi/+U7P
	H+kqJoFpYAtyoPPAiqwbL+Ik3y7pIHv1gGQtg40McSiGj/UMLDgpkOByvwIeOhNt8QHPbwjELxi
	1Pt4dMfVvijVR1T9BWQtDs36NYADsmgwD0dllDsY4vM83b8zHm4VKw5uMJW+EeK9IoHKvxzVhT0
	CRdpNJPEideSbTJE1s2qrGAHdkQR5t3Vf9kNnuEJJxiBwINWE2pRQY2C+NzfTF8oQrMX1g6Q9yf
	/x0gpaNwuINfUVw/N9AcXle9SrNA+euusQJGPQNIpUDiztTgXEX8s9SSpNRGzoQsqeBVedpKpiW
	0KLmXgkYsznvYRz6BbTq58uWF1JCSQ2wWrx5dylTnHCh/31dTSZ71GRdBKWO3AKj5TKmFRU5zko
	jYZ9iO6/Wr669EhJFsfwORlzoQgKK2uhWq1wUyhrwmCGKCUN7J4qCtcMytMvBHzIuOpipfDSFxM
	w0WJb39hktxAmDC34stJXoNoF87uNxxcf6pK36LQtdy7Qh3W//ExkFR6g5siRTuPznmQYup1cCy
	KLg==
X-Received: by 2002:a05:600c:4708:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4a18e4a6ea5mr20042355e9.13.1791534154867;
        Fri, 09 Oct 2026 01:22:34 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a128-aa01-297a-7094-853e-a20c.310.pool.telefonica.de. [2a02:3100:a128:aa01:297a:7094:853e:a20c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18ee9bd19sm19659975e9.1.2026.10.09.01.22.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 01:22:34 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] asm-generic: cmpxchg: always inline __generic_cmpxchg_local()
Date: Fri,  9 Oct 2026 10:22:23 +0200
Message-Id: <20261009082223.40760-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With gcc 8.1.0 and CC_OPTIMIZE_FOR_SIZE, an ARMv5 test module with
24 cmpxchg_local() callers for 1-, 2- and 4-byte values fails at
modpost with an undefined wrong_size_cmpxchg.

__generic_cmpxchg_local() uses that undefined symbol to reject
unsupported sizes. ARM used to force inlining of functions marked
inline. With compiler-controlled inlining, gcc can emit an
out-of-line copy that retains the call even for valid callers.

Mark it __always_inline so the compiler can fold each caller's
constant size and remove the unsupported-size path.

Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Notes:
    Sashiko noted that the generic helper still used plain inline while
    reviewing the cmpxchg inlining fix in my Rust ARM support series [1].
    This is a separate fix against v7.3-rc1. No in-tree build failure is
    known.
    
    With gcc 8.1.0, versatile_defconfig and CC_OPTIMIZE_FOR_SIZE,
    zImage and modules build without warnings before and after.
    
    External test modules built through Kbuild:
    
                                before    after
    12 valid callers            builds    builds
    24 or 96 valid callers      fails     builds
    Invalid 8-byte caller        fails     fails
    
    Valid callers use 1-, 2- and 4-byte values. The failures are modpost
    errors for undefined wrong_size_cmpxchg. The modules were built,
    not run.
    
    With clang 22.1.8 and CC_OPTIMIZE_FOR_SIZE, the patched
    versatile_defconfig kernel builds without warnings and boots to the
    initramfs shell in QEMU versatilepb (ARM926EJ-S).
    
    [1] https://lore.kernel.org/rust-for-linux/asg-nSs2cg7O-znd@gmail.com/

 include/asm-generic/cmpxchg-local.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/cmpxchg-local.h b/include/asm-generic/cmpxchg-local.h
index f27d66fdc00a..083f6688f137 100644
--- a/include/asm-generic/cmpxchg-local.h
+++ b/include/asm-generic/cmpxchg-local.h
@@ -12,8 +12,9 @@ extern unsigned long wrong_size_cmpxchg(volatile void *ptr)
  * Generic version of __cmpxchg_local (disables interrupts). Takes an unsigned
  * long parameter, supporting various types of architectures.
  */
-static inline unsigned long __generic_cmpxchg_local(volatile void *ptr,
-		unsigned long old, unsigned long new, int size)
+static __always_inline unsigned long
+__generic_cmpxchg_local(volatile void *ptr, unsigned long old,
+			unsigned long new, int size)
 {
 	unsigned long flags, prev;
 

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.39.5 (Apple Git-154)

