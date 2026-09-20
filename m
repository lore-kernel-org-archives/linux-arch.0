Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091B47252A
	for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2026 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933055; cv=none; b=ej9aBFmSxKqZPOPW365OGG1yrUdvc76vMpjnXzsJTZBaZjfRJQtVTsKu4lfmhI7tOygIYItw2OCxfRueFmle1hoC0gr/rIXRw6DvB7oREHM4ZYIEejGre6Qg1mPZ34omdHMR1pRNH58ANbfYkjpcBA6EpLQLShK+qf7TOir2lhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933055; c=relaxed/simple;
	bh=xr/NZJKBK6CUnL1RnXkkMJeJUXfe0jmUB3ZL22elyF4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsyA0x9ER0U7xqAZDWyAqmgC5Ls0kBCsDCzMIcaVwGR17Pn+ydAYS5sdbR5mxtHZ0RGErvKGVGW3HybdKxqPUoY7U2YQPTr7GuZihm8VAJqx3BQGPNxNSdqLlo8CISHF4XkR8DnoR5KkXU9erkWe4EOR3k1BXcrcz9XajxvuqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=SOBbeJIM; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="SOBbeJIM"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e56a1b327so1754438d50.0
        for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2026 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933050; x=1790537850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qTv8uFL1FYxhccWvDyiinfq9K+eUMO7fyy31bgvC6E4=;
        b=SOBbeJIMCs38dv8ZImJY+/7eltfI47qWOWzjYQxzXxAdJlAv2v/CCIDUatv+1nqw3c
         hYSbqJliDWfpOL9Igd56oFok7OvotwogIUTZ60Opz/cuqCRWDSG89RZ8V94Oa9nxKrEk
         oisxF1VcLEp8aQSIx/YAhRABu9FnA1gKzIgUIhkYijeZl4FB+23WSEumOdcyJxgaAZf5
         zuba/cQuvFK4PZetvfUYfNB5BG4Y5OXfqehUeOz4HqVIy6JxMZT6UL6AAJRwUKk/O/2m
         1TK3J3fvo8FDuVlHM2vsFvNJarglOrI1XWtKsM/Xt3VM8jZ8ih2S43qvO1/Xxiiclp9e
         aQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933050; x=1790537850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qTv8uFL1FYxhccWvDyiinfq9K+eUMO7fyy31bgvC6E4=;
        b=k5CeoZwOOnuGbV7uNzsZNuT9M/7ntPoo0CI1zPE/o+Oioc4+VtQEhJFWvDHIXeNEh9
         0OGD+hyEg/pm4CXsdzMSbrcZUIRoyY4U1oojWS/3lhZeCg4YUg5EI2VE7Mzc8Z0g7Ia2
         H0ltAMrLWPE7siP5FKB8ZiA/OKP68bBQ26RKJ0vjH5yxMzvMN+6Arw8Q2gmFRN7ulRJ3
         WQ4lTL/VwixNIWTEojYfrRMYd+NQwbwe/+0WcULwGzNnVy0K9GXPDcYI8XGtcRkBhGNb
         zfxOnLdC05/jdYJzkf5VbLU/2ACVcwoXWK79oROqtS3RgpdJtf/0D9f5UhPV1PFMKhBN
         6E9g==
X-Forwarded-Encrypted: i=1; AKwUvBz9qzJ68o/Dr0GapUouJpJJiv9K7NTNrzsLF5Y5tUZagl1cZb1SCtX8kckb9CzC2tI9TfgPQPoaHUmQ@vger.kernel.org
X-Gm-Message-State: AFuF++nvh3wS9WG3Qqg/Be1JBmODuldaaTYd+AT/Vh4xeTZR4Rj08KNG
	LiQGdNhloLxLLNmVWSIy9EPNfDJHFagwIeLC4O0EVEno+N9g5KlKH1KA+k4avT85z6I=
X-Gm-Gg: AYBFou3pq0YvVtqK795hUMasD3ZYXCILOoftyDhJVq4sPBg2YsxjiwqquA5CeQO6r/o
	mI3Be2nRYbHYRLRkIA/s9jwRNyOknaSlFUCaggrSB1WB0Of6OPx6UlpmktnEulHq4CY9SUYAUxv
	J8FBi1xS8wsSOeYPOTalWyiXPf2jkHGCfX+wRbwqnq5r2vdEZhOJ11Qkq5vdedc+h6TPtVhK+hc
	80wktfN/mkL0T3pX3WTcJMX2BjF/x2ZOAo9Hk/RQetJ9mqDAZyW+aMfRQNdxjlSkDE/M3u9ape4
	tAmM4yqhAfMlJuRM4P6QZ7dfdumMJcI9k91gJGt6Mnc3r4O54yT6Hz/RzEreP5wBMRb/tiUcWVh
	ntY4ij/Hi12Ar6CObd54/OQopCB4KHkaAN+HGzafsLVtQDpSUOAte9WUzoP4450HKeaYcfR9GQd
	mRYD7VTmnd2OBotMOEhvBYxSc42JqnpxyLyczJjK7B2qknbJDG7vGRQzTE/EwC4LFdUwY475Nh4
	aOHzbQEm+gB0v8BWbLe4fqCbWyE95jvTojljtO9au4Gx8uCOIyvfdvYkHBy+eLAh29hCtnyV2ZE
	YxOs71mnt9dgfy7+xVOW
X-Received: by 2002:a05:690e:134b:b0:671:70d1:d6e5 with SMTP id 956f58d0204a3-6717fe597a3mr2639510d50.87.1789933049997;
        Sun, 20 Sep 2026 12:37:29 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67298f64c7esm2656294d50.2.2026.09.20.12.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:37:29 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 06/46] x86/smp: Skip offline CPUs for REBOOT_VECTOR in native_stop_other_cpus()
Date: Sun, 20 Sep 2026 15:36:10 -0400
Message-ID: <20260920193650.3373435-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In native_stop_other_cpus(), cpus_stop_mask is initialized to
cpu_online_mask minus the calling CPU. However,
apic_send_IPI_allbutself(REBOOT_VECTOR) uses the APIC broadcast
shorthand when enabled, which delivers the IPI to all physical APICs
including offline CPUs.

Use __apic_send_IPI_mask(&cpus_stop_mask, REBOOT_VECTOR) so that
REBOOT_VECTOR is sent only to the target online CPUs in
cpus_stop_mask.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 985103cab16c..2449d15c6667 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -192,7 +192,7 @@ static void native_stop_other_cpus(int wait)
 	cpumask_clear_cpu(this_cpu, &cpus_stop_mask);
 
 	if (!cpumask_empty(&cpus_stop_mask)) {
-		apic_send_IPI_allbutself(REBOOT_VECTOR);
+		__apic_send_IPI_mask(&cpus_stop_mask, REBOOT_VECTOR);
 
 		/*
 		 * Don't wait longer than a second for IPI completion. The
-- 
2.55.0.1082.g2b9226bbc0-goog

