Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2725A33F
	for <linux-arch@vger.kernel.org>; Thu, 16 Apr 2026 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776310236; cv=pass; b=KRmDBuvUPY4vsDwrdSFen6nbciN4b1V+16h2AeiCk5EwCh5cx7yN8X5YE0SEfWwhQV62TrnjEPFlnpXnWjVG7L7vgyqkE1n39SqJ5TFdWm9wgOLTG/ASGZ4rCKfaEK5wk/oAPA/5AA0QASwTV9BozMuEGdcp8LW1tikLn7hNUTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776310236; c=relaxed/simple;
	bh=iTtON7C1saxGO1WpU3i+FepkxQvrPytkI30BQs9EQlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhsGC14G9b3M/FgMqpCT1AYWWRSIA77kuNR790IZGLUMyxlf5apBJDsIvEMCzxTTgXXEbv4qv3qjUhLGhS8zFtVDVrJLha9RIgDu7WpW6WOGnjzlB0dff579LlQPIK05lyHVsrSPR0twPt5Y9ULW4MRHyhPepzT9deZ39bunIH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q1VlrlmC; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1VlrlmC"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2d52c7f92b1so6712177eec.0
        for <linux-arch@vger.kernel.org>; Wed, 15 Apr 2026 20:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776310235; cv=none;
        d=google.com; s=arc-20240605;
        b=DP0MhdQMTHQX8a13stIF0FY8T64YmNllEeqw7UaD/NsI+xmT0SosMRe0CUiMqEbHaP
         uzG6kUBUeNwpS5WnRW0472VFqQC8MYLa0OvcSHeZAIf825lOeHtV3Q7UnM6kMcKgjRHW
         LBbBTKsBfBGHVrssnMjfD4RAtO/+Si7XMSZNs2fKOp7u0LzKl/23ZhEP1CKL6AD1t3S2
         v/tBHjX/8CC5uwi/sBasdMiSjITvcFGYlFW5pWm21/107uQpDh0WdwqDpNqZBq154Wzf
         aRDPPw9tVEfY90z4IPz97UP2J5UkV6J3PLvYVbY7CsPRHLgzkCpZ1qXJ+vdyEUcTl4ip
         A2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dpn4wedExfmNW/xYliv7dotiSXfXw7rsw6+UTSkfq+I=;
        fh=XxehISYQToWChfZlO6DBUGe02QkyLg7hqBBo+9S/Nq8=;
        b=H+I8TSY+5p+SkO++OvYVYJGRF/d6QB5iGE+lbPi+h6xC1V6EPtagUbajFWsmtC2n7h
         15sAcFCb6ytpaUS2pPDjcUkcZ/sFW0ChTFrfluP1V5R9Ry+Nkkptso4+AEDaiJc68c0c
         7gWCUIrkB3lr+XJ0sThiBNiuyzoRE86amwMaHaPmX/H2o8ocyQHax18Urk7MJUcMOl1T
         4mqL2zajkcptMswIF+Wweu01PWoQNFnXTb3frZqeGylZEZ9wAEw7Qg+VzGPa54z9jYtD
         2iTv1q1RFK+bBQ+zOm50O476Qy9/hX2FIlmmRQTxJ63FrQfM0h73BpwVNJQbUthf5y7Z
         9zRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776310235; x=1776915035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpn4wedExfmNW/xYliv7dotiSXfXw7rsw6+UTSkfq+I=;
        b=q1VlrlmCFrtVHE5hetzAOsBCWcGxb/CFhXHSSopeF/IlxAPo0DUBJ/C6gbvOrvJiYw
         cdceN5UReXjnL6InkeQtNyS50HI4ppuCooMyssWxnvX0g9UmryDd+Gyqq4X316cT7Xq8
         c+2Cn4IvuJrzVNY6pRkBZr9cXPscrF3I20+ssiCoyF2uvtU1JjnxT8DNPMsmMUpjIST+
         xqx4fbZU7R/wLJ6v9EW0ctWCZWKaKhltfVFfVB7WZZ3aKoJ3qHrPRHkCMZ7kDt5+SRYR
         7IUSa6kyHZCFaqwvvSrtCw9WaQryviOrSLkTsnzqesOFhS1yQ04NIG2hhbuwYPWvcjiQ
         pw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776310235; x=1776915035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dpn4wedExfmNW/xYliv7dotiSXfXw7rsw6+UTSkfq+I=;
        b=UpqlCbvxFnc6kZDu8iDH+FipRMcVE1UC5+L0FtXKtEI25gkLs6D/qZxlSfhl1PLyiz
         w25/g6fIwDpQAnwDAfjmoTk23E6lRkcZz3VYw72LcxALemNbE+ZHKG9a7vcOXjb7xN+3
         4zCWPKIxgKd/S5/Y/9ZQPUAydwHx0yWtQWA11o1hDSwYA5LHOP+UDna7YC7989bEDTAO
         WC8IHFmNEj4ZTOH+4de8uGyekxanzAAeAHxCMp6dDEKOrZoRfsKenVHzoBIfg4N2K7qc
         EVTUPxiUg4axV28a+d+ToGP+583dDJz82oxmtsG1RLnVN4fvGsD4G4KJSdKW7LPRs287
         7lNA==
X-Forwarded-Encrypted: i=1; AFNElJ9Lmq8itCmopsT89Oj9k2Iz/euGRJzAoIyia9+aK602zSmTxj2RTIjsVK6AJjsr8rHoz9mEGnEnKDNg@vger.kernel.org
X-Gm-Message-State: AOJu0YypYEq4ZGlXdVxQ2MMiXrIwhZw0xXhMgMbFkAeLCmsZuMOzGOH/
	mZyMqDCzLaQY6v/pKqaXl6JfZ7mI7lCznWilc6NAZ5sYsAdTv0HawcepQZFQz2/zVAPH97zuv05
	jdns7IS/GV/HQO2bmqjBkx9mpcNnjlzQ=
X-Gm-Gg: AeBDiesmAeA0ww04OtyYG/rWAql1N8gdYXBfBDSjhvDLlULwo4Rgk0q1gWLwHQud2VE
	wLglHbk12RV0vgQ8VolIHlIe9OjcLMFjr9IIOxxioLl7XOO5AG/VxsqK3k//njSDxGF5QUI5qDZ
	sEdhXQeOQlXw4NkmRsCOSPuz8kg8x+T6tR7pqrdobSoMVS25BMRIkuJApU0ioO/CvdazvtyDcei
	k6f/f7VoPsqon4xAHrxLFul85oAquD36dUcBSY1X5Fzwsosz6RyxTyAKPguA5Y9xMKhT8g5jQTv
	ndgZJCs=
X-Received: by 2002:a05:7300:e2cc:b0:2c1:7793:7bbb with SMTP id
 5a478bee46e88-2d5898a59fdmr13887470eec.27.1776310234537; Wed, 15 Apr 2026
 20:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com> <20251209051128.76913-4-zhangyu1@linux.microsoft.com>
In-Reply-To: <20251209051128.76913-4-zhangyu1@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Thu, 16 Apr 2026 11:30:18 +0800
X-Gm-Features: AQROBzAshGAwo61mQxzSw05B4fc-T0M_3Sz-I4zsvryqbMNOOaLRwnMtQN-AzBI
Message-ID: <CAMvTesDbCYPLowZ=RS4ZOwbY_hNixhop6t1ADjDQjJ8kWjwe3A@mail.gmail.com>
Subject: Re: [RFC v1 3/5] hyperv: Introduce new hypercall interfaces used by
 Hyper-V guest IOMMU
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, easwar.hariharan@linux.microsoft.com, 
	jacob.pan@linux.microsoft.com, nunodasneves@linux.microsoft.com, 
	mrathor@linux.microsoft.com, mhklinux@outlook.com, peterz@infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 1:13=E2=80=AFPM Yu Zhang <zhangyu1@linux.microsoft.c=
om> wrote:
>
> From: Wei Liu <wei.liu@kernel.org>
>
> Hyper-V guest IOMMU is a para-virtualized IOMMU based on hypercalls.
> Introduce the hypercalls used by the child partition to interact with
> this facility.
>
> These hypercalls fall into below categories:
> - Detection and capability: HVCALL_GET_IOMMU_CAPABILITIES is used to
>   detect the existence and capabilities of the guest IOMMU.
>
> - Device management: HVCALL_GET_LOGICAL_DEVICE_PROPERTY is used to
>   check whether an endpoint device is managed by the guest IOMMU.
>
> - Domain management: A set of hypercalls is provided to handle the
>   creation, configuration, and deletion of guest domains, as well as
>   the attachment/detachment of endpoint devices to/from those domains.
>
> - IOTLB flushing: HVCALL_FLUSH_DEVICE_DOMAIN is used to ask Hyper-V
>   for a domain-selective IOTLB flush(which in its handler may flush
>   the device TLB as well). Page-selective IOTLB flushes will be offered
>   by new hypercalls in future patches.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |   8 +++
>  include/hyperv/hvhdk_mini.h | 123 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 131 insertions(+)
>
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 77abddfc750e..e5b302bbfe14 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -478,10 +478,16 @@ union hv_vp_assist_msr_contents {  /* HV_REGISTER_V=
P_ASSIST_PAGE */
>  #define HVCALL_GET_VP_INDEX_FROM_APIC_ID                       0x009a
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE      0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST       0x00b0
> +#define HVCALL_CREATE_DEVICE_DOMAIN                    0x00b1
> +#define HVCALL_ATTACH_DEVICE_DOMAIN                    0x00b2
>  #define HVCALL_SIGNAL_EVENT_DIRECT                     0x00c0
>  #define HVCALL_POST_MESSAGE_DIRECT                     0x00c1
>  #define HVCALL_DISPATCH_VP                             0x00c2
> +#define HVCALL_DETACH_DEVICE_DOMAIN                    0x00c4
> +#define HVCALL_DELETE_DEVICE_DOMAIN                    0x00c5
>  #define HVCALL_GET_GPA_PAGES_ACCESS_STATES             0x00c9
> +#define HVCALL_CONFIGURE_DEVICE_DOMAIN                 0x00ce
> +#define HVCALL_FLUSH_DEVICE_DOMAIN                     0x00d0
>  #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS     0x00d7
>  #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS     0x00d8
>  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY  0x00db
> @@ -492,6 +498,8 @@ union hv_vp_assist_msr_contents {    /* HV_REGISTER_V=
P_ASSIST_PAGE */
>  #define HVCALL_GET_VP_CPUID_VALUES                     0x00f4
>  #define HVCALL_MMIO_READ                               0x0106
>  #define HVCALL_MMIO_WRITE                              0x0107
> +#define HVCALL_GET_IOMMU_CAPABILITIES                  0x0125
> +#define HVCALL_GET_LOGICAL_DEVICE_PROPERTY             0x0127
>
>  /* HV_HYPERCALL_INPUT */
>  #define HV_HYPERCALL_RESULT_MASK       GENMASK_ULL(15, 0)
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 858f6a3925b3..ba6b91746b13 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -400,4 +400,127 @@ union hv_device_id {              /* HV_DEVICE_ID *=
/
>         } acpi;
>  } __packed;
>
> +/* Device domain types */
> +#define HV_DEVICE_DOMAIN_TYPE_S1       1 /* Stage 1 domain */
> +
> +/* ID for default domain and NULL domain */
> +#define HV_DEVICE_DOMAIN_ID_DEFAULT 0
> +#define HV_DEVICE_DOMAIN_ID_NULL    0xFFFFFFFFULL
> +
> +union hv_device_domain_id {
> +       u64 as_uint64;
> +       struct {
> +               u32 type: 4;
> +               u32 reserved: 28;
> +               u32 id;
> +       } __packed;
> +};
> +
> +struct hv_input_device_domain {
> +       u64 partition_id;
> +       union hv_input_vtl owner_vtl;
> +       u8 padding[7];
> +       union hv_device_domain_id domain_id;
> +} __packed;
> +
> +union hv_create_device_domain_flags {
> +       u32 as_uint32;
> +       struct {
> +               u32 forward_progress_required: 1;
> +               u32 inherit_owning_vtl: 1;
> +               u32 reserved: 30;
> +       } __packed;
> +};
> +
> +struct hv_input_create_device_domain {
> +       struct hv_input_device_domain device_domain;
> +       union hv_create_device_domain_flags create_device_domain_flags;
> +} __packed;
> +
> +struct hv_input_delete_device_domain {
> +       struct hv_input_device_domain device_domain;
> +} __packed;
> +
> +struct hv_input_attach_device_domain {
> +       struct hv_input_device_domain device_domain;
> +       union hv_device_id device_id;
> +} __packed;
> +
> +struct hv_input_detach_device_domain {
> +       u64 partition_id;
> +       union hv_device_id device_id;
> +} __packed;
> +
> +struct hv_device_domain_settings {
> +       struct {
> +               /*
> +                * Enable translations. If not enabled, all transaction b=
ypass
> +                * S1 translations.
> +                */
> +               u64 translation_enabled: 1;
> +               u64 blocked: 1;
> +               /*
> +                * First stage address translation paging mode:
> +                * 0: 4-level paging (default)
> +                * 1: 5-level paging
> +                */
> +               u64 first_stage_paging_mode: 1;
> +               u64 reserved: 61;
> +       } flags;
> +
> +       /* Address of translation table */
> +       u64 page_table_root;
> +} __packed;
> +
> +struct hv_input_configure_device_domain {
> +       struct hv_input_device_domain device_domain;
> +       struct hv_device_domain_settings settings;
> +} __packed;
> +
> +struct hv_input_get_iommu_capabilities {
> +       u64 partition_id;
> +       u64 reserved;
> +} __packed;
> +
> +struct hv_output_get_iommu_capabilities {
> +       u32 size;
> +       u16 reserved;
> +       u8  max_iova_width;
> +       u8  max_pasid_width;
> +
> +#define HV_IOMMU_CAP_PRESENT (1ULL << 0)
> +#define HV_IOMMU_CAP_S2 (1ULL << 1)
> +#define HV_IOMMU_CAP_S1 (1ULL << 2)
> +#define HV_IOMMU_CAP_S1_5LVL (1ULL << 3)
> +#define HV_IOMMU_CAP_PASID (1ULL << 4)
> +#define HV_IOMMU_CAP_ATS (1ULL << 5)
> +#define HV_IOMMU_CAP_PRI (1ULL << 6)
> +
> +       u64 iommu_cap;
> +       u64 pgsize_bitmap;
> +} __packed;
> +
> +enum hv_logical_device_property_code {
> +       HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU =3D 10,
> +};
> +
> +struct hv_input_get_logical_device_property {
> +       u64 partition_id;
> +       u64 logical_device_id;
> +       enum hv_logical_device_property_code code;
> +       u32 reserved;
> +} __packed;
> +
> +struct hv_output_get_logical_device_property {
> +#define HV_DEVICE_IOMMU_ENABLED (1ULL << 0)
> +       u64 device_iommu;
> +       u64 reserved;
> +} __packed;
> +
> +struct hv_input_flush_device_domain {
> +       struct hv_input_device_domain device_domain;
> +       u32 flags;
> +       u32 reserved;
> +} __packed;
> +
>  #endif /* _HV_HVHDK_MINI_H */
> --
> 2.49.0
>
>

No code uses these definitions in this patch and it's better to merge
with Patch 5?
--=20
Thanks
Tianyu Lan
