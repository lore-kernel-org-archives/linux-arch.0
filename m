Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACDC47F794
	for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2026 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933160; cv=none; b=ks3sSEHPPxTJG3ZNbTXCkQoR1GUgHwpNT7kieDHr89XUIKJsHwrlKTeHeZFr6whwKD2PjjU9ulZYcoiE+M4YaBpsne8qiAHl5J4SCZm07UJc6JflNRYKpX8K7TX0xFv3674da3ilEMKnKnAwp4dVSeTfI+dw+NGNwxCJ0OsyT5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933160; c=relaxed/simple;
	bh=ecMTvF3y9YX9wt5R/rOdU59+hWMsUmT0QbE/UEYrczY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibIFv8jhs1HZZPs33RrNCbTMzSRckTa7TJAg/fdP9tuOekAYNPZSP9A0YPnGgy91etMzvtrIcstUhTa/sPOKR4XQhJHb63+BURqE5E6CF5EP1omDMT3pjaCF6LmTWFKaVJ4bpVtNeJLTTc5Vm+ogSdX0dv8yjnZWcXOLPw0XRZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=TW8caZte; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TW8caZte"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d440939f0so15991907b3.2
        for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2026 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933157; x=1790537957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GOyD94xneAEU7+yzaxi3P4vCBB/CkWgVuLYMi+o49fI=;
        b=TW8caZte+uentNlNiIUgcIPNJ5uG6Cc6Crp834ckEcz7g7LD9NK7GzNe9yo6YV/SU5
         yDJgHg2Yo3IMX0Y0jnXZjcKL65l8Xaha6fgt79Kb9NBkJH1GaKYd6CFTSrAN5IHXqKYS
         xedgK4h8Mvb3Wl1x4DlT9M7qnFUQ30DXSV4hLAAx+edJW+1ObpcgTYB4OUTRFq3q/ZeS
         8SZ9Y8C4+yARAFWl/0liVXdl7TmyIeo1pRgHd5qi92IbizWSEJ5QFTVgNh5DCRkBcyYQ
         dIvXOzhjRMANr0dxZReK3zhUvwV9GYenAZh+sqLeSRT24/nDM77BNXDQi4ugq0hm5daq
         gBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933157; x=1790537957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GOyD94xneAEU7+yzaxi3P4vCBB/CkWgVuLYMi+o49fI=;
        b=kv05I+pVO6Cz3MInkeUaDsdBTWiZS+WkUhKuMRfXagxCAiMddAA0fJobx2krxeQGN0
         EhpON9lqiKHxvIaVOMIRF7SqrHOShYedFHs9/aT6qtpnJT12dasfcyzUrS6ddaSpcs7P
         fZOv0QaNsn+2YN+BDK2XQIdT14Fq5xdAJuxVccmXJAQoqSwu5SrZI8DRH8MPMOAlAqVx
         yg8mq9mnDuHJFt24eP9FEJGegdeqMX8UJoX1y/brWP3pqw+r/iXy/MCNqhzWozx13Khn
         t+0y0WEV0qyPO18x6JT5yK6ODIAlhge1nWmp6NQn+98qf6RZdFOQMmAHTDQh0GpsXLFW
         JZvQ==
X-Forwarded-Encrypted: i=1; AKwUvByarLDVgF9UM1tS+R5+/JU1dnumW7UcHEtMcYeq7CbCDYg3DPXREndWWu3ayhE2sYpVeIAoLqnlBkjP@vger.kernel.org
X-Gm-Message-State: AFuF++kqOuzKPs/PDlcCkgeZL8Cn9tv7hRgtoycpsTitTD2v1wBujDlJ
	Q8NU2wqhu+Ha7scW3TUuxWVcreoXrn4/qpzbjSb1VuNM5Ed2kYxaou71oCuFSs8reak=
X-Gm-Gg: AYBFou1hd8mrUrj+WAibqyi3nd46sR8k+1huSHV4+jaAS2Yy/ZC++WF8LhHMMuO6qTU
	czlzFyZhIH5+X7qcW7Ynq7Enk401hnI7BEIvW5oOKKQIuwGxnYubxsnEoYex3kd004xlttIL3Mn
	+sOCU3mj8+s1vgMaTBiZBQVrqI1iSwUiBlhK0UTWrJvf025H5QSjHcfZJUg3YRtahM7Fs+paWzZ
	2rqSEdkgZjLVw7+tSPJ3hNFJ+pcYWOrfKaKo7lTXz0YLKXQO/jZkxAnc3Tx4ORCmDCQH/LdzvnO
	8LlVw00DXl6K6J1kxqr7eIdclgyajGKD59zgtv9Egxlz1Hob/qMlcONB40IWvx/SV7T5mVwkwvd
	PoNY6M3HhzCPZxo6+JkknauDpkK1XEb+5jSmNA7YBQri/E7eRrsl1kJ8IAiDiyuVB/SmRPiIuoG
	OOEfzDfm1Nwji4Oha8mqeRNshJkX1MkoRvcemXnj95MsVsxBqJp8zVj/Y4q2umPuqz7te2Km5AT
	rIO1wxtU8h7wy9Mp1u59EOK7Cq2e1kI5R+H0OeHbwnWh+y43pk7tEocshljbS9A2/7/1iNLu+rF
	XKH+34Q6M/mf7wCiB60=
X-Received: by 2002:a05:690c:e3cf:b0:845:ddf4:a399 with SMTP id 00721157ae682-897308f89e5mr31680887b3.11.1789933156801;
        Sun, 20 Sep 2026 12:39:16 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a4761747asm18686667b3.30.2026.09.20.12.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:39:15 -0700 (PDT)
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
Subject: [RFC PATCH 24/46] MAINTAINERS: Add entry for KVM Caretaker
Date: Sun, 20 Sep 2026 15:36:28 -0400
Message-ID: <20260920193650.3373435-25-pasha.tatashin@soleen.com>
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

Add KERNEL VIRTUAL MACHINE CARETAKER section in MAINTAINERS covering
Caretaker headers, architecture backends, and core execution files.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 23f332cfbd16..86806245041e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14296,6 +14296,17 @@ F:	tools/kvm/
 F:	tools/testing/selftests/kvm/
 F:	virt/kvm/*
 
+KERNEL VIRTUAL MACHINE CARETAKER
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	kvm@vger.kernel.org
+L:	kexec@lists.infradead.org
+S:	Maintained
+F:	arch/*/include/asm/kvm_caretaker*
+F:	arch/*/kvm/*caretaker*
+F:	arch/x86/kvm/mmu/kho.c
+F:	include/linux/kvm_caretaker.h
+F:	virt/kvm/caretaker*.c
+
 KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)
 M:	Marc Zyngier <maz@kernel.org>
 M:	Oliver Upton <oupton@kernel.org>
-- 
2.55.0.1082.g2b9226bbc0-goog

