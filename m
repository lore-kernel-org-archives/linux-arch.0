Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097743D25C5
	for <linux-arch@vger.kernel.org>; Thu, 21 May 2026 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366024; cv=none; b=d+rzbSYtv0kBtCMwz9dap5hwI+9wK/5YnF1MfXKTCveDLGtpjw1kNn11yhg48A0IPqDUA7dQvmC4O6rnW8MXNVt312r50HKcdS+d33H4GZse03Bxv9n9U8WCpi9SNDWcOaUKbXvXoTrSINOU4ssS7vu7wIDh0frSp49J9gv466Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366024; c=relaxed/simple;
	bh=m5vq5lzBfI3cQdgIp7nM79N6LDabjGabpgW/KV4LQy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktn8raK5W92G+A4nLC76fcCKfw8ZDH8lQgb2RUT1rMwVjf8ZdwAjr42/C/ti11R796P7QjsIdF3eYwP0KKx8kQ6UA5fP/2shpBW/SfO2VKgAq4bG0mcDEmtMnyM9qvZ0iCIabT3W6LJc7qBmz6hL8PBB8zWcy2Sq5VxDjI1/738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ImEv4Ai5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cLMrNeV9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ImEv4Ai5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cLMrNeV9"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99uxn3772801
	for <linux-arch@vger.kernel.org>; Thu, 21 May 2026 12:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TwK02OO4K1epQED36FGkSoJT4inoRnIOR99uClBefzI=; b=ImEv4Ai599CkKWct
	28BA/t+9vRGd5MBP7ry2a53XDrFhmSAHGsRtyliCdQ5YKRfW1Bh1Gxns0N4G6ssK
	HQET9yhe8qDT6Jy2C/JFNNPd/qE2aWrX3PEyGEQTTy8vHmvk76zfeWM7feJ3k5ga
	RGKcE1FLRVm9bx55awCHNyRoLTicBQBYgsRo/1etey2TNkPVJX243Z6+PVqx5brP
	qKocHiZtcdEL3XAQOUeWmmkrh8DCY2g2e844j7AFlirWv67+T15Vb3eu1Sc1fg/0
	zZ9MMzUelSnBhh/QDqO992G3e4SyivLJq4ojL6/eu2cafltwEvyb+EILUw2EmW1J
	zYPTCw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma43595-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 21 May 2026 12:20:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c827c880e39so3056003a12.0
        for <linux-arch@vger.kernel.org>; Thu, 21 May 2026 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779366021; x=1779970821; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TwK02OO4K1epQED36FGkSoJT4inoRnIOR99uClBefzI=;
        b=cLMrNeV9Uh0cbmZtjrwnUReHA1vLzJ+Q+kSi8B6WTLxXsDUze+X+vbv627UMa0YCss
         e63Bh1xM4L6X9ufiH7Ktpk1e5q0H93NJ9mbL3UaVzmj9aVdDvLxRdtz05jw1duM1sSYt
         wOtsPLmJjrBolRQ6HwF6SNiaX8bniMgSfxwgvf85ZVgKPQPnhdlIREWcTrADlFUKYrUo
         YZX/so/HsB/nUjm7guDF9Kzthvl9oerzKPJpx9BM64rPSij7AHapFKzUu1K8SH73FnBp
         TkAKzVS/ad116VHg4oQx2gs1A5WxdjO9wXspQV1d5EaQFHHmvxWrSFMo8FuC9ko46/cb
         LpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779366021; x=1779970821;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TwK02OO4K1epQED36FGkSoJT4inoRnIOR99uClBefzI=;
        b=XDJ6a2QCZArbpQmNFl1nz6vCW/wxu+2lYqJjkpTviKyPwGsSUQiP5D9CpBp3gjU6SK
         M+F3fH7UgHz1OR+rb9bMs54oB3ORxRIbbvtK8TRT0WwzcBU3v5RUcCe76t2MWnHtmlSh
         X3gthynefsVa/1sJgf+Kauw/SHk2OSjt7F57yPg2pRIMveaCp7eqzYC8wfe1qpyY+nj2
         3WdqI2lZ3pKr9oL1IroJObvC7/fnCExOoeUwfT9P9ZAml+dTVVM4kY/7wrqoAkDHW3vq
         mgkC7Q/lcBo35ENKbljoAhMAWCkftwTzisBVSIjdpjNVEnuCnI9Oe2TB+S/IlD+prPc+
         EMBg==
X-Forwarded-Encrypted: i=1; AFNElJ95s4TertWwSL3c8xF0FbBZqTJwKelHcA2lD+S3qCbXNRO+DXJXx33UN0gGH21XHPzd2whoudltzeVk@vger.kernel.org
X-Gm-Message-State: AOJu0YzI3P9LimKYX9ZlIKpshIhrdz5KcfDYL8b2tdo9G+NMWtS2ATBe
	TmkKLEC79wjxZ661gurRg0LPFI3ViYzRT5l1XDbRO1GW/FvP8MU5qygnAcZmxs6YhyQUnPDM8N9
	QVl+ejyKHxvlCpIGNkiQop47cXjb72Lx2uGOYpV07wd5whEbawpYBAl64DtO7mDkO
X-Gm-Gg: Acq92OHh8u9Cc8DpvsE2b0nk3HnAyLowbkBfNo/IR+iZZXEoFS94W2d7o4vc07SWAoh
	+J4i3rIMguQ6yvTIYyxDvIIEO0ZnaDpNjhzQ5Vv/RsK2LCyMhWjUoCBNFJ0IdvBFvMldp8WW72S
	l+Epth7RsPwCkHq87PJoyakYfvY++iZ+7pFSAG+Ua7Liu9+JmsoR94OhOe9MmdGB4m21NKIVCT0
	4l3zo8AuFFGgkKtlT2voKdm+6zEJWHNpH1VG7ogcISCFufZ/3YYzDMbW0pHfZ2W4zQi3Q0pyuw1
	vsIZZoeKqAltU+Svp+bIE0p9Sjl4Y+2Hpm/JP0GFd+nH03H0Kv4LA9e8Q3FbVnOnOqP3T1fMYdF
	9PBdjEKHTL+ZqhSh+jXv6BB8ClNOtwyECNgabhRiRnYBc4q3wLiaaK8itWGw=
X-Received: by 2002:a05:6a20:9183:b0:398:6bb5:54c4 with SMTP id adf61e73a8af0-3b30854e9c4mr3264412637.5.1779366020821;
        Thu, 21 May 2026 05:20:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:9183:b0:398:6bb5:54c4 with SMTP id adf61e73a8af0-3b30854e9c4mr3264348637.5.1779366020198;
        Thu, 21 May 2026 05:20:20 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c851980bcdcsm240706a12.14.2026.05.21.05.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:20:19 -0700 (PDT)
Date: Thu, 21 May 2026 17:50:02 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
        Eugen Hristev <eugen.hristev@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Kees Cook <kees@kernel.org>, Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
        Youngjun Park <youngjun.park@lge.com>, Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 00/25] Introduce meminspect
Message-ID: <20260521122002.etqupwnjv67didat@hu-mojha-hyd.qualcomm.com>
References: <20260311-minidump-v2-v2-0-f91cedc6f99e@oss.qualcomm.com>
 <abdnp90cC5PI9wyz@baldur>
 <20260316181647.m7x4ncmwdjho6yvr@hu-mojha-hyd.qualcomm.com>
 <abtlUQqMOxj5PwGB@baldur>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abtlUQqMOxj5PwGB@baldur>
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0ef885 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=mDV3o1hIAAAA:8 a=0QWIX89dG7aUu2ROjmkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: RBWs0uCP9HaG13tBuGDQ7Q8fIgw-7Bw0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyMyBTYWx0ZWRfX8GNBv0ujJxt2
 aFPbaOLYaRMxIRsZ31Qb5dOAyHjPr47OafYOI8lrwGXKiagYj4iCYGFXLRxC2xMUjQq0m/pKUaY
 BUn2LKdhJSMqD3+J5ev9ZqgaTJpGZc6Cx6m5nof521PjP9ezptw34q2j9DKMzl2F8DKLhevJIB3
 NgSSAwdavyonSc0zt67fF42gxX/ApeK/qSkPIXpWZN2bWHv50WOoc0bd9kVl3Oz4zOMHA6rNsEK
 oCAJojwDLz14Ul2IohvYAPDeH9IQitn06piWnVN5MfrVN2eyl+zeM/P87ZU57Dwrxg4jNOSg3L6
 nuoX428M081gFYbM3ToI0d6omXRQB4vlVhAMPY1gr8wsiGA89Jq+etjjQbK7MjpaMJ5QKp7O0jH
 zYfBl0jPQO9Wwk6tAq47S80erSgUB0m8ynwQEleZ3uqtei4tHLGZUWXJKTYEERWxolcj813JKcF
 Ih2q1uuBUfHq71au1Zw==
X-Proofpoint-ORIG-GUID: RBWs0uCP9HaG13tBuGDQ7Q8fIgw-7Bw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210123

On Wed, Mar 18, 2026 at 09:55:29PM -0500, Bjorn Andersson wrote:
> On Mon, Mar 16, 2026 at 11:46:47PM +0530, Mukesh Ojha wrote:
> > On Sun, Mar 15, 2026 at 09:24:39PM -0500, Bjorn Andersson wrote:
> > > On Wed, Mar 11, 2026 at 01:45:44AM +0530, Mukesh Ojha wrote:
> [..]
> > > >, to get all the regions as
> > > > separate files.  The tool from the host computer will list the regions
> > > > in the order they were downloaded.
> > > > 
> > > > Once you have all the files simply use `cat` to put them all together,
> > > > in the order of the indexes.  For my kernel config and setup, here is my
> > > > cat command : (you can use a script or something, I haven't done that so
> > > > far):
> > > 
> > > So these need to be sorted in numerical order, by that number at the end
> > > of the file name?
> > > 
> > > Do you manually punch these in? How do we make this user friendly?
> > 
> > Yes, manually.. but I think we can do better. We could make
> > this more user‑friendly by using the section header and string table in
> > the md_KELF binary both of which existed in the earlier implementation.
> > Then, we can write an upstream‑friendly script that reads this KELF
> > metadata file, checks whether a binary with the registered name is
> > present, and stitches everything together to form a complete ELF that
> > the crash tool can consume.  Let me know if you have any suggestion..
> > 
> 
> Can we somehow identify that these regions belong to the minidump and
> teach QDL to build the ELF for us?

Raised PR for the QDL https://github.com/linux-msm/qdl/pull/243 which
does not use numerating order and we can completely drop.

With that PR, QDL will be generating minidump.elf .

And I checked the latest crash tool with no extra patching and just the
--minimal option (as we do not have everything in the minidump) and just
dmesg.


$ ./crash  --minimal minidump/vmlinux ./minidump/minidump.elf

crash 9.0.2++
Copyright (C) 2002-2026  Red Hat, Inc.
Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
Copyright (C) 1999-2006  Hewlett-Packard Co
Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
Copyright (C) 2005, 2011, 2020-2024  NEC Corporation
Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
Copyright (C) 2015, 2021  VMware, Inc.
This program is free software, covered by the GNU General Public License,
and you are welcome to change it and/or distribute copies of it under
certain conditions.  Enter "help copying" to see the conditions.
This program has absolutely no warranty.  Enter "help warranty" for details.

GNU gdb (GDB) 16.2
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "--host=x86_64-pc-linux-gnu --target=aarch64-elf-linux".
Type "show configuration" for configuration details.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...

NOTE: minimal mode commands: log, dis, rd, sym, eval, set, extend and exit

crash> log
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x512f0030]
[    0.000000] Linux version 7.1.0-rc2-next-20260504-00228-g2595b97d6061 (@f134cd6ce783) (aarch64-linux-gnu-gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #11 SMP PREEMPT Fri May 15 09:34:41 UTC 2026
[    0.000000] KASLR disabled on command line
[    0.000000] random: crng init done
[    0.000000] Machine model: Qualcomm Technologies, Inc. XXXX
[    0.000000] earlycon: qcom_geni0 at MMIO 0x0000000000a9c000 (options '')
[    0.000000] printk: legacy bootconsole [qcom_geni0] enabled
[    0.000000] efi: UEFI not found.
...
..


[   48.488296] sysrq: Trigger a crash
[   48.492004] Kernel panic - not syncing: sysrq triggered crash
[   48.497944] CPU: 3 UID: 0 PID: 363 Comm: sh Tainted: G        W           7.1.0-rc2-next-20260504-00228-g2595b97d6061 #11 PREEMPT
[   48.510055] Tainted: [W]=WARN
[   48.513140] Hardware name: Qualcomm Technologies, Inc. XXXX
[   48.519699] Call trace:
[   48.522276]  show_stack+0x18/0x24 (C)
[   48.526089]  dump_stack_lvl+0x34/0x8c
[   48.529903]  dump_stack+0x18/0x24
[   48.533366]  vpanic+0x47c/0x4dc
[   48.536646]  do_panic_on_target_cpu+0x0/0x1c
[   48.541078]  sysrq_reset_seq_param_set+0x0/0x94
[   48.545788]  __handle_sysrq+0xd4/0x1b8
[   48.549679]  write_sysrq_trigger+0xc0/0xd0
[   48.553930]  proc_reg_write+0x9c/0xf0
[   48.557737]  vfs_write+0xd4/0x358
[   48.561187]  ksys_write+0x6c/0x104
[   48.564724]  __arm64_sys_write+0x1c/0x28
[   48.568809]  invoke_syscall+0x54/0x10c
[   48.572704]  el0_svc_common.constprop.0+0xc0/0xe0
[   48.577578]  do_el0_svc+0x1c/0x28
[   48.581025]  el0_svc+0x38/0x138
[   48.584317]  el0t_64_sync_handler+0xa0/0xe4
[   48.588660]  el0t_64_sync+0x198/0x19c
[   48.592474] SMP: stopping secondary CPUs
[   48.796761] Kernel Offset: disabled
[   48.806510] Memory Limit: none
crash>

-- 
-Mukesh Ojha
