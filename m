Return-Path: <SRS0=t1zw=CH=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F02FC433E6
	for <linux-arch@archiver.kernel.org>; Sat, 29 Aug 2020 08:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E01D2075B
	for <linux-arch@archiver.kernel.org>; Sat, 29 Aug 2020 08:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gcq01isl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgH2I0b (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 29 Aug 2020 04:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbgH2I0Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2020 04:26:24 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06031C06123A;
        Sat, 29 Aug 2020 01:26:24 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l2so2166161eji.3;
        Sat, 29 Aug 2020 01:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AgnMShIR6M9zxB3f3djmyVOwSU+pv1up9yjWprNIX24=;
        b=Gcq01islUqGbrpF7zysAfXQj4yE9tvxGnE+Ww5gmM6OgXo9ho2NkSfTN6b9MBUYbbf
         x4/NeQauUFOXBNNfmq2sFyiEhmKdeWoeWVLSMiTeJivXjVYnQILl84mS5Rv+W5niagAd
         3Z40SA5rSa03KVG3f8x6hF2njdtIpAQbKNn6qVMc08K1nhpVryM4PkISzvCpUOKhSgMF
         d0BFtX/mOBgBdjQIGqcDBHCmqJkdgtTpZst9qQRY57f7Q8whRXguyM8vvkaN/BGWljtZ
         2co6dPj9AUCMyMiYpKiRzKAlfiR2zngfHlTJ2yjSNe4QiA/R2uU3oq0d67zUi39HCvwk
         WEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AgnMShIR6M9zxB3f3djmyVOwSU+pv1up9yjWprNIX24=;
        b=XWK4Ry+8Q359Ew1jvHt0ubyrB2VeqiwWURyG2cGMbSXU+6ILpEp83mkgXpID3+tP6+
         tietzS09lt06lyIvNlVztjDJKUIRd4RngjiEIFaZPxd1eh67fAxywlRqN6YtzPQqxYw/
         lMfA+Q9vvihR51OkgGUqt7ROsBwQqPaddcFiZmzbIqCtBTnN09FpcipBUOqF4j55iRHy
         RXJD5Xf2PUtyOEy0IBmpFXGNRre1oGqq4FvJ3h4idYvZiM6Xy3IsmR0qrIJg78YvJkOO
         rSGA3WB4IkoZNtPs2BB5bA4v/sZ8cg3IooO8MEvL/VkOVSQpsHrLr8lCIqr6B0PfCnel
         i0SA==
X-Gm-Message-State: AOAM532IRxqPVQ3ElHHr9WTcXQSNbGs9C6ouxPGjWZ17SB/8TCnVxsD0
        nGaW/km9qBvWnaCCGrmLqQGr4R+oWzs=
X-Google-Smtp-Source: ABdhPJySNupr5WHRWSdq2Vn5kz/f4r7mwlfdsSLuCjRUTDCUzhsYRG694aPosSsr8ub4itbFpWwYzQ==
X-Received: by 2002:a17:906:29cc:: with SMTP id y12mr2605246eje.212.1598689582729;
        Sat, 29 Aug 2020 01:26:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id b23sm1566538eja.86.2020.08.29.01.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:26:22 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@kernel.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2 3/3] dics/memory-barriers.txt/kokr: Allow architecture to override the flush barrier
Date:   Sat, 29 Aug 2020 10:26:07 +0200
Message-Id: <20200829082607.3146-4-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829082607.3146-1-sj38.park@gmail.com>
References: <20200829082607.3146-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Translate this commit to Korean:

    3e79f082ebfc ("libnvdimm/nvdimm/flush: Allow architecture to override the flush barrier")

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Yunjae Lee <lyj7694@gmail.com>
---
 .../translations/ko_KR/memory-barriers.txt          | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 291039d77694..64d932f5dc77 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -1904,6 +1904,19 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
      "커널 I/O 배리어의 효과" 섹션을, consistent memory 에 대한 자세한 내용을
      위해선 Documentation/core-api/dma-api.rst 문서를 참고하세요.
 
+ (*) pmem_wmb();
+
+     이것은 persistent memory 를 위한 것으로, persistent 저장소에 가해진 변경
+     사항이 플랫폼 연속성 도메인에 도달했을 것을 보장하기 위한 것입니다.
+
+     예를 들어, 임시적이지 않은 pmem 영역으로의 쓰기 후, 우리는 쓰기가 플랫폼
+     연속성 도메인에 도달했을 것을 보장하기 위해 pmem_wmb() 를 사용합니다.
+     이는 쓰기가 뒤따르는 instruction 들이 유발하는 어떠한 데이터 액세스나
+     데이터 전송의 시작 전에 persistent 저장소를 업데이트 했을 것을 보장합니다.
+     이는 wmb() 에 의해 이뤄지는 순서 규칙을 포함합니다.
+
+     Persistent memory 에서의 로드를 위해선 현재의 읽기 메모리 배리어로도 읽기
+     순서를 보장하는데 충분합니다.
 
 =========================
 암묵적 커널 메모리 배리어
-- 
2.17.1

