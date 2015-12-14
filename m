Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:33051 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932790AbbLNXhu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Dec 2015 18:37:50 -0500
From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH 02/11] resource: make resource flags handled properly
Date: Mon, 14 Dec 2015 16:37:17 -0700
Message-ID: <1450136246-17053-2-git-send-email-toshi.kani@hpe.com>
In-Reply-To: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
References: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, bp@alien8.de
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Toshi Kani <toshi.kani@hpe.com>
Message-ID: <20151214233717.-MbVCCmkS_MoCrwMU6nIjmM8Ul4aZ7MCnzCPg9bwmIE@z>

I/O resource flags consist of I/O resource types and modifier
bits.  Therefore, checking I/O resource type of the flags must
be performed with a bitwise operation.

Fix find_next_iomem_res() and region_intersects() that simply
compare the flags against a given value.

Also change __request_region() to set res->flags from
resource_type() and resource_ext_type() of the parent, so that
children nodes will inherit the extended I/O resource type.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reference: https://lkml.org/lkml/2015/12/3/582
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
---
 kernel/resource.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index f150dbb..d30a175 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -358,7 +358,7 @@ static int find_next_iomem_res(struct resource *res, char *name,
 	read_lock(&resource_lock);
 
 	for (p = iomem_resource.child; p; p = next_resource(p, sibling_only)) {
-		if (p->flags != res->flags)
+		if ((p->flags & res->flags) != res->flags)
 			continue;
 		if (name && strcmp(p->name, name))
 			continue;
@@ -519,7 +519,8 @@ int region_intersects(resource_size_t start, size_t size, const char *name)
 
 	read_lock(&resource_lock);
 	for (p = iomem_resource.child; p ; p = p->sibling) {
-		bool is_type = strcmp(p->name, name) == 0 && p->flags == flags;
+		bool is_type = strcmp(p->name, name) == 0 &&
+				((p->flags & flags) == flags);
 
 		if (start >= p->start && start <= p->end)
 			is_type ? type++ : other++;
@@ -1071,7 +1072,7 @@ struct resource * __request_region(struct resource *parent,
 	res->name = name;
 	res->start = start;
 	res->end = start + n - 1;
-	res->flags = resource_type(parent);
+	res->flags = resource_type(parent) | resource_ext_type(parent);
 	res->flags |= IORESOURCE_BUSY | flags;
 
 	write_lock(&resource_lock);
