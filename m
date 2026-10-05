Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0920D531AEF
	for <linux-arch@vger.kernel.org>; Mon,  5 Oct 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220771; cv=none; b=IRu6JpbJ6Ssny5RygCMEdBIp98gJyDIP3yxO97ICbN6nUkfLwr4cxz7C5x4eMMi2t0GHIqds2SXLenVDnECBcQriHRwlgjSlTLnp00p3rvHirDsqc/+xAdVm6Kl7wRz4Dhrevl11NF7gPqZsh09lYqqZACdoeD9eSlQ61j6S1sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220771; c=relaxed/simple;
	bh=DSy90Vi1pYW2azdUTwrc0TT6kW6QsQGO8Rlo/8MHFWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsjf7cU2Sh0UjxEkM3kM5YcjUXcmGvd8rWw6cI/mQ+ry5KjZMU+dwt66GwLAOZnRG4hEpGCyHmIPiT3zJcnqtOLzyNhmE3b9AueJB11uF8yWX6EXhAR7roAGeoBaKz1AiQjG1EZC4A9MD7oqNfZ6sAQGeVcLDMaao6G1O8tY4Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGnt2UfA; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGnt2UfA"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so900864a12.3
        for <linux-arch@vger.kernel.org>; Mon, 05 Oct 2026 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791220768; x=1791825568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j4yfFb6320kdlQ6cch251gfqYxfn4Y6pwvS8rFGl1n0=;
        b=gGnt2UfAUg8JGW1bFWJFnF7t2rGWUEm8RerDWNKaHe0IPoU+2PYQczquL4Y/sP1+K6
         /xwns+zHRaVLuX5NbVo4kPcLLWJ+KSbbhC6Y9cjktEFpPYmQDegqOnRceQpPFZ3/jSgT
         tX46Nt+1DaDU06KHwCjTq14Jmz0NeNtHge1pAmCJwUQBGx5STGlxVHxDAhuUA9lcdH2S
         8+mYO+2lDIWMgmOIlB+CxKC9e8HogVa3aS3QaHjakCTysQQ/xT1uV7efuW0pAcKpXd2d
         ptUfmOrUB/w9dEY8138jPEq3eazJO3NDawGjapb/04CPKcRVixg5F/hKHtE/6vRtfyp8
         ScdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791220768; x=1791825568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j4yfFb6320kdlQ6cch251gfqYxfn4Y6pwvS8rFGl1n0=;
        b=FjH7pwB7hTTL1jm0laIRJtRtKgchapNZOgjkmOL4ac0uRjZRz+6DpuRHBSEdygmPeC
         kiahrLUBUCps+cuyOHaXT4bF6qMvkIpWVs7Ex08HzpOAo/tS1fo8DVrngWrHjuRSAZ3Y
         k/cLkBkn4qpyQhBsQBNumbL2Z5nulsPwOg4V2/WaZemSNXi1xxhYLEW+XpU8UTMjXf1T
         rPlDUJ9CByTf5yyIiup7+Iva4pCwZw8uXFUeKRAslJ/ecT/ToA/++fqmiBqenp2gVqrb
         rG1oNp+YN3B7a2IPUnIwqEbU04fZO+CnodY3dZJGoUlRT5O5kkT2i5mDC4vCtTso4uaS
         f7TQ==
X-Forwarded-Encrypted: i=1; AKwUvByDHsb+CUFicazwFdU0e/vOR3ElZ9y2voGBaFJTtpAwo7Bchey0QNzBfFr4i1sd3FskHAt0et7i4AvJ@vger.kernel.org
X-Gm-Message-State: AFq9FYJW7ueZ84LNzTJgnfocQuBMAaWKVtzY8fbFxQvPCnenI2PJyU4H
	BWKqY2aEtDHVCfz1JC9As8Q1Gk7z8iKFLGu9Ocmx3eGxDfX7GPHSMQjf
X-Gm-Gg: AYBFou3AlZdm9S22R7rf899G/81/ikf+QIl6uzxICvv4UCvj71SnmHZsE6WWctk9UTb
	Ed99KLwiFFZJ/piWGv3Og3mg6oBEDQO8l6MqXRQwMy1dclGEBztEYCr4x3CEPsOtGy3mBovJlQx
	ee4oeKj+jqeG+11twpitvMzU159+5Jerj3mSFe7y1tokneXgrn5QVjUhygyx9C5mOpTMBwKIUHS
	lzRoUpGTs2jF9CKMfpPFGrI8YG52Woj7ZRC7FbRIUPjRFrjWbY/EU6jkPEs9Gu5BX79Z0nvj6NN
	iaJ9lQRFr5sbd3U5w/C3zARtgJTMMyBsA2Qbsbfukt5I/RekAkriDiGJ1ADl+CaTvnkJ1m1djOY
	8ljC67m+FEAfO1lnFYxcdaZY/n8B3iGdQDe8LAfUoHvhHxoE1Bqga/dp3KPtRD/Dd5gz6IIgmIH
	EoiErs7AwBmJGQD+M+rqe9IqNPK3gso1n44pyWeTv5Z/QyWInJWZmobpX/Qtk8rlubDhs9AID5+
	6af57D9PQmpkYZVevlZVAxFvEELFA==
X-Received: by 2002:a17:90a:2cc4:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-3a78eca8911mr3952064a91.18.1791220767601;
        Mon, 05 Oct 2026 10:19:27 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cafddesm406910a91.10.2026.10.05.10.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:19:26 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net,
	lianux.mm@gmail.com
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun@kernel.org,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC v3 15/15] selftests/rcutorture: add hazptr torture test script
Date: Tue,  6 Oct 2026 01:15:29 +0800
Message-ID: <20261005171529.1378809-16-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005171529.1378809-1-kunwu.chan@gmail.com>
References: <20261005171529.1378809-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hazptr.sh as a one-command regression test for the hazptr
torture configs.

Run NOPREEMPT, PREEMPT, READERS0, and READERS4, followed by
LOCKDEP with wq_churn and SLOWPATH with CONFIG_PROVE_LOCKING=y.
The latter two also check the console for lockdep warnings.

With --allcpus, repeat the PREEMPT test at CPU counts 8, 16, 32,
and so on up to 256.

Follow the pattern of the existing srcu_lockdep.sh script.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 .../selftests/rcutorture/bin/hazptr.sh        | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/hazptr.sh

diff --git a/tools/testing/selftests/rcutorture/bin/hazptr.sh b/tools/testing/selftests/rcutorture/bin/hazptr.sh
new file mode 100755
index 000000000000..ef636e519a55
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/hazptr.sh
@@ -0,0 +1,146 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Run hazptr torture tests and report any that fail.
+#
+# Usage: hazptr.sh [ --cpus N ] [ --allcpus ] [ --datestamp string ]
+#
+# Copyright (C) 2026 Kunwu Chan
+#
+# Authors: Kunwu Chan <kunwu.chan@gmail.com>
+
+usage () {
+	echo "Usage: $scriptname optional arguments:"
+	echo "       --cpus N       override CPU count (default: auto-detect)"
+	echo "       --allcpus      test at CPU counts 8,16,32,...,256"
+	echo "       --datestamp string"
+	exit 1
+}
+
+ds=`date +%Y.%m.%d-%H.%M.%S`-hazptr
+scriptname="$0"
+
+RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
+PATH=${RCUTORTURE}/bin:$PATH; export PATH
+. functions.sh
+
+cpus=""		# empty = let kvm.sh auto-detect
+allcpus=0
+
+while test $# -gt 0
+do
+	case "$1" in
+	--datestamp)
+		checkarg --datestamp "(relative pathname)" "$#" "$2" '^[a-zA-Z0-9._/-]*$' '^--'
+		ds=$2
+		shift
+		;;
+	--cpus)
+		checkarg --cpus "(number)" "$#" "$2" '^[0-9]\+$' '^--'
+		cpus="$2"
+		shift
+		;;
+	--allcpus)
+		allcpus=1
+		;;
+	*)
+		echo Unknown argument $1
+		usage
+		;;
+	esac
+	shift
+done
+
+nerrs=0
+
+run_kvm () {
+	local ds_suffix="$1"
+	local configs="$2"
+	local cpu_arg="$3"
+	local kconfig="$4"
+	local resdir="$RCUTORTURE/res/$ds/$ds_suffix"
+
+	mkdir -p "$resdir"
+
+	tools/testing/selftests/rcutorture/bin/kvm.sh \
+		--torture hazptr \
+		--duration 5s \
+		--configs "$configs" \
+		${cpu_arg:+--cpus "$cpu_arg"} \
+		${kconfig:+--kconfig "$kconfig"} \
+		--trust-make \
+		--datestamp "$ds/$ds_suffix" > "$resdir/kvm.sh.out" 2>&1
+	return $?
+}
+
+check_lockdep () {
+	local ds_suffix="$1" config_dir="$2" label="$3"
+	local resdir="$RCUTORTURE/res/$ds/$ds_suffix"
+	local console="$resdir/$config_dir/console.log"
+
+	if ! test -f "$console"
+	then
+		echo "Missing console.log for $label ($ds_suffix)" > "$resdir/kvm.sh.err"
+		return 1
+	fi
+	if grep -qE "WARNING: possible (recursive locking|circular locking dependency)" "$console"
+	then
+		echo "Lockdep warning in $label" > "$resdir/kvm.sh.err"
+		return 1
+	fi
+	return 0
+}
+
+# Basic torture: all hazptr configs, CPU count auto-detected
+
+echo "--- hazptr basic torture${cpus:+ ($cpus CPUs)} ---"
+run_kvm basic "NOPREEMPT PREEMPT READERS0 READERS4" "$cpus" || nerrs=$((nerrs+1))
+
+# LOCKDEP: verify no lockdep splats with PROVE_LOCKING + wq_churn
+
+echo "--- hazptr lockdep + wq_churn ---"
+if run_kvm lockdep-wq LOCKDEP "$cpus"
+then
+	check_lockdep lockdep-wq LOCKDEP "LOCKDEP wq_churn" ||
+		nerrs=$((nerrs+1))
+else
+	nerrs=$((nerrs+1))
+fi
+
+# SLOWPATH + PROVE_LOCKING: verify forced-slowpath does not deadlock
+
+echo "--- hazptr SLOWPATH + lockdep ---"
+if run_kvm slowpath-lockdep SLOWPATH "$cpus" \
+	"CONFIG_PROVE_LOCKING=y"
+then
+	check_lockdep slowpath-lockdep SLOWPATH \
+		"SLOWPATH+PROVE_LOCKING" ||
+		nerrs=$((nerrs+1))
+else
+	nerrs=$((nerrs+1))
+fi
+
+# CPU scaling: optionally test at multiple CPU counts
+
+if test "$allcpus" -ne 0
+then
+	max_cpus=`grep '^processor' /proc/cpuinfo 2>/dev/null | wc -l`
+	for n in 8 16 32 64 128 256
+	do
+		if test "$n" -le "$max_cpus"
+		then
+		echo "--- hazptr CPU=$n ---"
+		run_kvm "cpu$n" "PREEMPT" "$n" "CONFIG_NR_CPUS=$n" || nerrs=$((nerrs+1))
+		fi
+	done
+fi
+
+# Report
+
+if test "$nerrs" -ne 0
+then
+	echo "hazptr.sh: $nerrs test(s) failed"
+	exit 1
+fi
+echo "hazptr.sh: all tests passed"
+exit 0
-- 
2.43.0

