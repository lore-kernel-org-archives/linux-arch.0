Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5465F3E3153;
	Mon,  6 Jul 2026 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318857; cv=none; b=g1ZXqJKjKsrQt9Gos3s6HKerne67Qo5RS9XZEkwmQAUTf1RcOB+nizbR2f4Vsw1flH5M/B02qUicQkLp2UgMS3LyWARmaOoqxaVnOhcijEzQOI3Do2xBzQCU0TrYuzx67/L70E1wP52U2Y7EfpdRbDCtPo6sWyc2JrE6gKuRo/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318857; c=relaxed/simple;
	bh=zZ0Z4ACi/Apbu1QY77b88sFXV1NHqKJHKoHUY4xopZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DJtSRqXl7YqgKeGygJxebaA08Z803kZSij0JdAxxeu1dD3JOWZH/8ufLNRCqGYQlq0NSAmAhcVS8psgInvd9hiRwQTiy0jYD2MutPAgBh/lj56SRGruUw6D7EbNq6isF2eVFH8+k6qlcW5L0zFGCKk5J8YeIUcf29WVbBKo32mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-62-6a4b48ff0ae4
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: max.byungchul.park@gmail.com,
	kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yunseong.kim@ericsson.com,
	ysk@kzalloc.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	sumit.semwal@linaro.org,
	gustavo@padovan.org,
	christian.koenig@amd.com,
	andi.shyti@kernel.org,
	arnd@arndb.de,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	surenb@google.com,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	chuck.lever@oracle.com,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kees@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mark.rutland@arm.com,
	ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com,
	wangkefeng.wang@huawei.com,
	broonie@kernel.org,
	kevin.brodsky@arm.com,
	dwmw@amazon.co.uk,
	shakeel.butt@linux.dev,
	ast@kernel.org,
	ziy@nvidia.com,
	yuzhao@google.com,
	baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com,
	joel.granados@kernel.org,
	richard.weiyang@gmail.com,
	geert+renesas@glider.be,
	tim.c.chen@linux.intel.com,
	linux@treblig.org,
	alexander.shishkin@linux.intel.com,
	lillian@star-ark.net,
	chenhuacai@kernel.org,
	francesco@valla.it,
	guoweikang.kernel@gmail.com,
	link@vivo.com,
	jpoimboe@kernel.org,
	masahiroy@kernel.org,
	brauner@kernel.org,
	thomas.weissschuh@linutronix.de,
	oleg@redhat.com,
	mjguzik@gmail.com,
	andrii@kernel.org,
	wangfushuai@baidu.com,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	2407018371@qq.com,
	dakr@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	neilb@ownmail.net,
	bagasdotme@gmail.com,
	wsa+renesas@sang-engineering.com,
	dave.hansen@intel.com,
	geert@linux-m68k.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v19 18/40] dept: apply timeout consideration to waitqueue wait
Date: Mon,  6 Jul 2026 15:19:06 +0900
Message-Id: <20260706061928.66713-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260706061928.66713-1-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTH9zz3Ps+97SzedWTe6QeWLnOLBvcSISfLRtiybHczcb7ELNlL
	XGOvo6wUU4SBGVk3S1aZsIqhDPCluMgKrYBVRKigY5YJC10rRCqC1s0ABoobsgJSZa2b3/75
	/8755Xw4PKMeJSt5vXG3bDJqDRqqZJWRZXWp+N0N2S/dmHscDjW7KVg91QQCTS4EJe1LLCx1
	9iCwBysYCAXOM+A+/TWGuy0PKFTevEXhTv1+BDVjtRxEbngJDEWnEEza/6IwczuMYOBWEvRW
	fkdhbLgTQ3u4g4PgZAzDiL0Cw2+2YxjsJ1dAbdUEhsoTXgxLjlzocY1z0BT5nUDv9SsE2sxh
	DmYHb2KwdvzDwkDHIQrX3UsErvV/z8HxoSCGaPkqCBwoIzAZrWfgatUUB5cvODA4/64i0NDZ
	T6HFUsNB6/kSBN9OeCn01/oJDF71IuiyhjFcbG7D0Dz2CwPHnREC4zWHMfSN3uXg3k8+BH33
	+jD8UR6JC3xzHFhG0mBxPn7EfMufBGZdjRSmbbMkM1OaKylnpZLL96nkPuJGUnvNKCdZuoY5
	yeHJl04510g/nruNpeHJ1yVP4z4qeWYqOKlucYKRSiODWBq5co5K034/J136YZHdlPKh8jWd
	bNAXyKYXMz5VZg0dC5JdrVxh74MFakYWWooUvCisF53uavIot/oPPOyp8LwYCi0wiZwsPCOe
	KhuLzyh5RhhIEffXl7EJ8KSwUWzbG4kDnmeF58TwwtuJWiWki3UD5v+dKaKr5cJDjyLeN8UO
	40RWC2nitTu/sgmnKBxViPboLP5v4WnxZ2eItSGVAz3WiNR6Y0GOVm9Yvy6ryKgvXLcjN8eD
	4k9XXxz76CyaCWztRgKPNMtUkPletppoC/KKcrqRyDOaZNXqFzZkq1U6bdEe2ZS73ZRvkPO6
	0Sqe1axQvRL9QqcWPtPulj+X5V2y6RHFvGKlGW2LebbsbUAk4+i0L6m9B4ptR5xcdlL+VHnq
	2mKrMdSM+zJcjtRLW4aXv1prXL3wzcHqzQfPmH3L09Vpz46eqNA36Ao/vm9PqgvOp7/lPRMz
	CL5tn1xce1r9hOOdufE3tu7MtPr36N6sSrbQD2y5CvKU/csOW1Ep3/X+5n0bv9oZ0LB5WdqX
	1zCmPO2/VgO56nADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTcRTG+9+X/66jxW0ZXgoxFqkU9gIWB4ooorq9SfQl6IVa7pbTOWMz
	S0NS18re52KTmppZjtBZpplprUTJMlu5VimpqbBW4tQop0ydNou+HJ7z/M55OB8OQ0pr6QWM
	Up0qaNRylQyLKXHcWl3MNL8jceULx1LI1Z+Brh43DZ+zGyjwjeRSUPDAhiFgqRVBbtUNGl63
	51DQdr8cQY8vF8HYhIUEfd00BQFjswhG/J0iMGUjmLY3IzA7jSR0tL0gwfYom4DflVMYBpp+
	ITD1uTHk92dTMGy9jOCmxyKC/pdbYbDnKQ3T3d8JaB/1IrC6pwhwN5xHEDAnwa2S6uC6+SeG
	Ccd7EvJNbQhu93WT8Ku/F8Gj5q8I7PdyMHwz1JDgcs+Bj75hDC2mSxgGnQUEDFViKM6x0+B8
	O4Cg0GJE4PliJ0B35wEGc2EVBXW99SJwDkwS0GU2ElBetQt6rB4KWg0lRPDc4NTDMLDk64hg
	+UGAqeIpAX5rmWhDKeLH9Fcpvqz6McHrPwQwbyuyIX5i3Ij4kVIdyesNwbbJO0zyZ6tP8qWt
	XsyP+z5h3j5aTPFvSjj+7oVxgs9zxPB1N7tFuzfuE69TCCplmqBZsf6wOKG9xEkfrxGdapny
	4yx0Fl9EIQzHxnI17/L+asxGcR0dfnJGh7KLuOorHvoiEjMk64rgLluvUDNgHhvH1eoGg4Bh
	KHYJ1+vfMmNL2DXcbVcW/S8zgiuvbPibExL0708WEjNayq7mOodfUQYkLkazylCoUp2WLFeq
	Vi/XJiWkq5WnlsenJFeh4DtZMyfznqAR19ZGxDJINlsCG7YnSml5mjY9uRFxDCkLlURG70iU
	ShTy9AxBk3JIc0IlaBvRQoaShUm27xUOS9lj8lQhSRCOC5r/lGBCFmShcKHp0n7x4oqD9c9j
	PU80Ec1Ru0LLIgcDIes2OxRDYerzC78uq8/c41BEH2DIlnMVcXfH9tWc3onqwsszZUdu4Mii
	obnxnX3Xw+dvTHrojY5JUOgXkae37DxqHcUHfftfdn1KJeNd3kDAoZJ+kG+KNYiv2bZltGSY
	nkmob8YoWkZpE+SrlpIarfwPjIP3fkoDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to waitqueue wait, assuming an input 'ret' in
___wait_event() macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index c8f8b44060fb..a9524bc8630b 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -306,7 +306,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 	struct wait_queue_entry __wq_entry;					\
 	long __ret = ret;	/* explicit shadow */				\
 										\
-	sdt_might_sleep_start(NULL);						\
+	sdt_might_sleep_start_timeout(NULL, __ret);				\
 	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
 	for (;;) {								\
 		long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);\
-- 
2.17.1

