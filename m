Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6EA47DFBF
	for <linux-arch@vger.kernel.org>; Wed,  6 May 2026 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075593; cv=none; b=nwoX5iwwOOSMVUvOHlBTsWpZNpdJDSaDYilUH6ZhbSSyoiuE3QlMRFBAHKvtusU0o2EXvTzsLXaV1Jt/3CnFKF4r/sVWk1RHCt4w81DmKAcTwPIWL8zXi/On2EJGQbXK1inZtFHqtVxAPF15mOBx3QGJEEHtfTbJMrSTJXs61KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075593; c=relaxed/simple;
	bh=WPy43tWwGLD16tLk3adfAOx6qHTQUenXbMiXY+eWGp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VA8QE0VG1CrNW/JIbbly/Rq7IJUELT8kUTPNGWR8LUz+2QvkNpfGRnHDC2krQbdZaE5GIJDq+YRu9lM8NXVcyOOPIX6D4sfqcsHT3UMH+2yL9HJaBb0Pq3celvCeRH9d9MrXobofXJJLsMLpbQ82XMZNclIqrja7bx0Id/MMpVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NYMfmHK+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tv2mk4kp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NYMfmHK+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tv2mk4kp"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646A4gnY3524218
	for <linux-arch@vger.kernel.org>; Wed, 6 May 2026 13:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DRyMypCoE/AnYhKuT36BdRoiWJW6dKR5NkRP1R7YP0s=; b=NYMfmHK+k6TMcBEs
	JB9N2sy1XkQHuUHVdI/THYFtE0WxtAX91a1dzCyQdKbwy+bxool0SLY5hhgphytW
	nxvwQ16ReG/JsWYfAX6njU68onXbdP4fD6VcqEy07vxAA62Cnm4XWiyIndyQMYID
	TimzxroM/7pbv/a/vg7IwSAcm2VZ7QXRBQDDgVAu8aEvfHst0G+s10R2hD7JC/iy
	b1aqv6Ph3k2aBqoD5N3YwbGD4YjBlda3traTHT8YBJTOi8SuZPM1pcm7DOsVBEVA
	Cd8gTuLnrhPnHaFDYxRIq8dnZQkELY5EUOJPqLVLpC+qqs9ZIAkJskptUeTgKbOI
	FNs28A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03jwrrj0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 06 May 2026 13:53:09 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d84b5f73bso215171031cf.0
        for <linux-arch@vger.kernel.org>; Wed, 06 May 2026 06:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778075588; x=1778680388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRyMypCoE/AnYhKuT36BdRoiWJW6dKR5NkRP1R7YP0s=;
        b=Tv2mk4kpAklepknjbvj5owP+wTcRrSxOyiqzSzWeoc5WjmrMPLpT9MbOBeCUfVfp0p
         CoczDAE8t2Jy0Q11/nFReHq2qP93mq5QCxfUzHr1h66EgarFkZMZHgQ3IQwge72xXB82
         EE53+RB/6DynKA627k8fwTE0HPDUMBb/aWjjVJCD6PgzrF5XncUfxuy6WpVRSstrz6zc
         KHkyLZGV4mXA3r28Gwf4Sy+eRuQGdMDHM8m2xz0vF5/0vujGbpmpZbiJieHwL0yCGJRG
         6A+rkJUhLdvRgwI2UabiJ6jJRPJfylkNiUpv9n0AO0LpGMkr9y/z2AL+ObhYY9i9V4yk
         ka1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778075588; x=1778680388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DRyMypCoE/AnYhKuT36BdRoiWJW6dKR5NkRP1R7YP0s=;
        b=hgrMzsKVtiMpKCBYVKe1q3Yw+jztOWDs5/ik+dRnWIBLePs//cKf3UucrZEGW19Via
         8j4ehG9OmFFUYqVj5ek+SS6zahPPen489wqrTRxXk9dEtO57XPtEa5H+MKcfcsI+46y1
         3RII3EiCEeBWhnaB1mHMbPaqI370e3CZJWdc3Yt7I/0CWriWu3kF0gHASttiYSDBgjZ2
         M4jCxrNHIaaxExxgHoSA57as2eRfHWg/d50w5pZ2aNnLkK5E7b4xlS2a9EkISw8qih1d
         N+u9+lAByD510UaqNVbHms0UUhSoG+zj4P5gnJw/8zuiSG+8Hoihoji8k6/O/+xBa7ru
         BDlA==
X-Forwarded-Encrypted: i=1; AFNElJ96UzyY9ROGyDxsEdQgxMmXQnMbiuHVUQTozgcw1RU2ChiLEeT/cIOQ+WnHV4DRdBcPijvYt55BM2O7@vger.kernel.org
X-Gm-Message-State: AOJu0YxCXiM1f09pU1QYYhglsx4eSWQNnRyq8GoCfpZnPxLXS4W3s1Om
	/PNKKGqU8bGr3WpuGNOwD0PxSqn3jsx9HBoZWDVhNlDeLWmAx+Ti+qkqn9nVoc6pWYM7LSUNad0
	kTzBrjwjqI6FcsOq97BjaX2sMtDyzwjbwzLEuwyMSmcm0puJ+40g+E5XzwybOKcQM
X-Gm-Gg: AeBDietZaQP/RtISBwfoFF0XxtR7/haWqZ8XLNkbLkPzG8ELkBL3cFkFeP7L5PsmIJz
	4Jdkg54V0SkSUaA9d/3Z8M3w0M9zqz3N8xfsRyQ8n9AF2exuDNQJfC15y8dj3BBCgBXOAGFH1hD
	t38SPtYFPB4NgovVhsrrfW1EOWNvFcANQc94lATYBzpj4+RN6xF+5/mEDxGuvRLZ9k1Fkdu1Z3S
	mZaFl3Kvm3+ppiZ3vy0BRBk0xttX6jVh7SF4YxqYgeBJOZYLcRtMitglXOmFBoqyc6tDsayL/Y/
	UWF+H+MBxAgWIVD2CQu4nAcFhGT8sfQLb9lXHLB9WqV67ZtNB74npPg/U8mMqCbwFmHrdggsEIo
	CUoJSfPJQoGQi8qQTv/1L+hLlvO194NzoHac8idVVl/uHIUmSyMnMCOMJ4mIR
X-Received: by 2002:a05:622a:138b:b0:509:2b02:c1bd with SMTP id d75a77b69052e-51461c1e0f5mr52170611cf.12.1778075588251;
        Wed, 06 May 2026 06:53:08 -0700 (PDT)
X-Received: by 2002:a05:622a:138b:b0:509:2b02:c1bd with SMTP id d75a77b69052e-51461c1e0f5mr52170071cf.12.1778075587741;
        Wed, 06 May 2026 06:53:07 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:41ef:7b80:b3e8:2c1a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a5486sm52091945e9.6.2026.05.06.06.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:53:06 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, gregkh@linuxfoundation.org,
        tglx@kernel.org
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [RFC PATCH 1/1] clocksource/drivers/timer-probe: Create a platform_device before the framework is initialized
Date: Wed,  6 May 2026 15:52:42 +0200
Message-ID: <20260506135242.4191560-2-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506135242.4191560-1-daniel.lezcano@oss.qualcomm.com>
References: <20260506135242.4191560-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J4CaKgnS c=1 sm=1 tr=0 ts=69fb47c5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=ag1SF4gXAAAA:8
 a=1MyLDUlQoYkTeSRXZBgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzNiBTYWx0ZWRfXyAQR9uyiXVVH
 2nXzfHYrKpCMlw2Suk+0E/BI/lpt57/ehh5v7QYzUvZlUAwvMHeJTQWVPG2Iw+B5ZdG0PkzkoKg
 lis1M2h0M9QMv4U7KW40DrRrlo2+W0vEYavkz9RM8LHnlj+6Zm8gzfvudtprSyC3JaXkGtDbsqe
 LbNowCxs+GtyufNzWSeH36LeWd7dUtIILyv64SH6b5XKFdfr03Y5c5k2ZkDMShUNVV/PTu/Pk5+
 m8ie6Dd8C4TYO6tMxXgLXcvAf4vxLMZqI22usPy8mqzFO6BEk4h4W0pLhzPE3gTEq7Pm7F1kL2o
 RCuhnllV6O2jIcaGKscsSkMPRFeDr9FEzNNp+abg1KMFAPVYxdO8/FTOi/Zk1GK8MHat7Oh5WO2
 ou2jDwKaBmULcrQoFA0AUw2XhRHeOzOFfQoYkmhZUs2Rk53w/47dAn8fsb4Zy5r6bhnMc3xU3rl
 K/T5Sw5tFq7q+qD6vWg==
X-Proofpoint-GUID: zH5sWZpLahyZ1WqodW1SIXZrj4_HTvx0
X-Proofpoint-ORIG-GUID: zH5sWZpLahyZ1WqodW1SIXZrj4_HTvx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060136

In the context of the time keeping and the timers, some platforms have
timers which need to be initialized very early. It is the case of the
ARM platform which do not have the architected timers.

The macro TIMER_OF_DECLARE adds an entry in the timer init functions
array at compile time and the function timer_probe is called from the
timer_init() function in kernel/time.c

This array contains a tuple with the init function and the compatible
string.

The init function has a device node pointer parameter.

The timer_probe() function browses the of nodes and find the ones
matching the compatible string given when using the TIMER_OF_DECLARE
macro. It then calls the init function with the device node as a
pointer.

But there are some platforms where there are multiple timers like the
ARM64 with the architected timers. Those are always initialized very
early and the other timers can be initialized later.

For this reason we find timer drivers with the platform_driver
version. Consequently their init functions are different, they
have a platform_device pointer parameter and rely on the devm_
function for rollbacking.

To summarize, we have:
 - TIMER_OF_DECLARE with init function prototype:
   int (*init)(struct device_node *np);

 - module_platform_driver (and variant) with the probe function
   prototype:
   int (*init)(struct platform_device *pdev);

The current situation with the timers is the following:

 - Two platforms can have the same timer hardware, hence the same
   driver but one without alternate timers and the other with multiple
   timers. For example, the Exynos platform has only the Exynos MCT on
   ARM but has the architeched timers in addition on the ARM64.

 - The timer drivers can be modules now which was not the case until
   recently. TIMER_OF_DECLARE do not allow the build as a module.

It results in duplicate init functions (one with rollback and one with
devm_) and different way to declare the driver (TIMER_OF_DECLARE and
module_platform_driver).

This proposed change is to unify the prototyping of the init functions
to receive a platform_device pointer as parameter. Consequently, it
will allow a smoother and nicer module conversion and a huge cleanup
of the init functions by removing all the rollback code from all the
timer drivers. It introduces a TIMER_PDEV_DECLARE() macro.

The platform drivers registered through TIMER_PDEV_DECLARE() are not
registered with the driver core. Instead, their probe function is
invoked directly during early init, as the full driver model is not
available at this stage.

If the early initialization is needed, then the macro usage will
result in a platform_device manually allocated and initialized with
the needed information for the probe function. Otherwise the
module_platform_driver can be used instead with the same probe
function without the timer_probe() usage like any other devices using
the driver model.

This mirrors the existing TIMER_OF_DECLARE() behavior while allowing
a unified probe interface and enabling the use of devm-managed
resources in timer drivers.

The plan is to have all timers to use TIMER_PDEV_DECLARE with all the
init functions cleanups and then remove the TIMER_OF_DECLARE macro.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Hans de Goede <hansg@kernel.org>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clocksource/timer-probe.c | 63 ++++++++++++++++++++++++++++++-
 include/asm-generic/vmlinux.lds.h | 10 +++++
 include/linux/clocksource.h       | 21 +++++++++++
 3 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
index b7860bc0db4b..f4705a78eee1 100644
--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -7,13 +7,14 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/clocksource.h>
+#include <linux/platform_device.h>
 
 extern struct of_device_id __timer_of_table[];
 
 static const struct of_device_id __timer_of_table_sentinel
 	__used __section("__timer_of_table_end");
 
-void __init timer_probe(void)
+static int __init timer_of_probe(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
@@ -38,6 +39,66 @@ void __init timer_probe(void)
 		timers++;
 	}
 
+	return timers;
+}
+
+static int __init __timer_pdev_probe(struct platform_driver *drv)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+	const struct of_device_id *match;
+	unsigned int timers = 0;
+	int ret;
+
+	for_each_matching_node_and_match(np, drv->driver.of_match_table, &match) {
+		if (!of_device_is_available(np))
+			continue;
+
+		pdev = platform_device_alloc(of_node_full_name(np), -1);
+		if (!pdev)
+			continue;
+
+		ret = device_add_of_node(&pdev->dev, np);
+		if (ret) {
+			platform_device_put(pdev);
+			continue;
+		}
+
+		dev_set_name(&pdev->dev, pdev->name);
+
+		ret = drv->probe(pdev);
+		if (!ret) {
+			timers++;
+			continue;
+		}
+
+		if (ret != -EPROBE_DEFER)
+			pr_err("Failed to initialize '%pOF': %d\n", np, ret);
+
+		device_remove_of_node(&pdev->dev);
+
+		platform_device_put(pdev);
+	}
+
+	return timers;
+}
+
+static int __init timer_pdev_probe(void)
+{
+	struct platform_driver **drv;
+
+	for_each_pdev_timer_table(drv)
+		__timer_pdev_probe(*drv);
+
+	return 0;
+}
+
+void __init timer_probe(void)
+{
+	unsigned timers = 0;
+
+	timers += timer_of_probe();
+	timers += timer_pdev_probe();
 	timers += acpi_probe_device_table(timer);
 
 	if (!timers)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 60c8c22fd3e4..1efdac063560 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -359,6 +359,15 @@
 #define THERMAL_TABLE(name)
 #endif
 
+#ifdef CONFIG_TIMER_OF
+#define TIMER_TABLE(name)						\
+	. = ALIGN(8);							\
+	BOUNDED_SECTION_POST_LABEL(__##name##_timer_table,		\
+				   __##name##_timer_table,, _end)
+#else
+#define TIMER_TABLE(name)
+#endif
+
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
 	__dtb_start = .;						\
@@ -731,6 +740,7 @@
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
 	THERMAL_TABLE(governor)						\
+	TIMER_TABLE(pdev)						\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
 	EARLY_LSM_TABLE()						\
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 7c38190b10bf..b7595e589fd5 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/clocksource_ids.h>
+#include <linux/platform_device.h>
 #include <asm/div64.h>
 #include <asm/io.h>
 
@@ -295,6 +296,26 @@ extern void timer_probe(void);
 static inline void timer_probe(void) {}
 #endif
 
+extern struct platform_driver *__pdev_timer_table[];
+extern struct platform_driver *__pdev_timer_table_end[];
+
+#define TIMER_PDEV_DECLARE(__name, __probe, __remove, __match)		\
+	static struct platform_driver __pdev_timer_table_entry_##__name = { \
+		.probe = __probe,					\
+		.remove = __remove,					\
+		.driver = {						\
+			.name = #__name,				\
+			.of_match_table = __match			\
+		},							\
+	};								\
+	static struct platform_driver *___pdev_timer_table_entry_##__name \
+	__used __section("__pdev_timer_table") = &__pdev_timer_table_entry_##__name
+
+#define for_each_pdev_timer_table(__pdev)     \
+	for (__pdev = __pdev_timer_table;     \
+	     __pdev < __pdev_timer_table_end; \
+	     __pdev++)
+
 #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
 	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
 
-- 
2.43.0

