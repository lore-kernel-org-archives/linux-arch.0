Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:43395 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbcAESzX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jan 2016 13:55:23 -0500
From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v3 02/17] resource: make resource flags handled properly
Date: Tue,  5 Jan 2016 11:54:26 -0700
Message-ID: <1452020081-26534-2-git-send-email-toshi.kani@hpe.com>
In-Reply-To: <1452020081-26534-1-git-send-email-toshi.kani@hpe.com>
References: <1452020081-26534-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, bp@alien8.de
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Toshi Kani <toshi.kani@hpe.com>
Message-ID: <20160105185426.k93cNzE4h2XA8Y1rzOKKNhFv6q8ECzZ5k-_pGNXkJ9M@z>

I/O resource flags consist of I/O resource types and modifier
bits.  Therefore, checking an I/O resource type in 'flags' must
be performed with a bitwise operation.

Fix find_next_iomem_res() and region_intersects() that simply
compare 'flags' against a given value.

Also change __request_region() to set 'res->flags' from
resource_type() and resource_ext_type() of the parent, so that
children nodes will inherit the extended I/O resource type.

Link: http://lkml.kernel.org/r/<CA+55aFy4WQrWexC4u2LxX9Mw2NVoznw7p3Yh=iF4Xtf7zKWnRw@mail.gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
