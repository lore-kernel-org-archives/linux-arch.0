Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266474AbUIOOCr@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41630 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266311AbUIOOCT
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2004 10:02:19 -0400
Received: from willy by www.linux.org.uk with local (Exim 4.33)
	id 1C7aMU-0004XT-EB
	for linux-arch@vger.kernel.org; Wed, 15 Sep 2004 15:02:18 +0100
Date: Wed, 15 Sep 2004 15:02:18 +0100
From: Matthew Wilcox <willy@debian.org>
Subject: [PATCH] pcibus_to_cpumask
Message-ID: <20040915140218.GE642@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: <willy@www.linux.org.uk>
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


'morning, cracksmokers.

How did anyone manage to come up with the ridiculous notion of passing
a single integer to pcibus_to_cpumask?  Surely all NUMA machines have
multiple domains?  Repeat after me: PCI busses are structs, not integers.
Completely untested patch against 2.6.9-rc2 follows:

Index: linux-2.6/arch/x86_64/kernel/pci-gart.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/x86_64/kernel/pci-gart.c,v
retrieving revision 1.19
diff -u -p -r1.19 pci-gart.c
--- linux-2.6/arch/x86_64/kernel/pci-gart.c	13 Sep 2004 15:22:49 -0000	1.19
+++ linux-2.6/arch/x86_64/kernel/pci-gart.c	15 Sep 2004 13:57:45 -0000
@@ -193,7 +193,7 @@ static void *dma_alloc_pages(struct devi
 	int node;
 	if (dev->bus == &pci_bus_type) {
 		cpumask_t mask;
-		mask = pcibus_to_cpumask(to_pci_dev(dev)->bus->number);
+		mask = pcibus_to_cpumask(to_pci_dev(dev)->bus);
 		node = cpu_to_node(first_cpu(mask));
 	} else
 		node = numa_node_id();
Index: linux-2.6/drivers/pci/probe.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/pci/probe.c,v
retrieving revision 1.14
diff -u -p -r1.14 probe.c
--- linux-2.6/drivers/pci/probe.c	13 Sep 2004 15:23:21 -0000	1.14
+++ linux-2.6/drivers/pci/probe.c	15 Sep 2004 13:57:49 -0000
@@ -54,7 +54,7 @@ postcore_initcall(pcibus_class_init);
  */
 static ssize_t pci_bus_show_cpuaffinity(struct class_device *class_dev, char *buf)
 {
-	cpumask_t cpumask = pcibus_to_cpumask((to_pci_bus(class_dev))->number);
+	cpumask_t cpumask = pcibus_to_cpumask(to_pci_bus(class_dev));
 	int ret;
 
 	ret = cpumask_scnprintf(buf, PAGE_SIZE, cpumask);
Index: linux-2.6/include/asm-i386/topology.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-i386/topology.h,v
retrieving revision 1.5
diff -u -p -r1.5 topology.h
--- linux-2.6/include/asm-i386/topology.h	13 Sep 2004 15:24:03 -0000	1.5
+++ linux-2.6/include/asm-i386/topology.h	15 Sep 2004 13:57:50 -0000
@@ -61,9 +61,9 @@ static inline int node_to_first_cpu(int 
 }
 
 /* Returns the number of the node containing PCI bus 'bus' */
-static inline cpumask_t pcibus_to_cpumask(int bus)
+static inline cpumask_t pcibus_to_cpumask(struct pci_bus *bus)
 {
-	return node_to_cpumask(mp_bus_id_to_node[bus]);
+	return node_to_cpumask(mp_bus_id_to_node[bus->number]);
 }
 
 /* Node-to-Node distance */
Index: linux-2.6/include/asm-x86_64/topology.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-x86_64/topology.h,v
retrieving revision 1.10
diff -u -p -r1.10 topology.h
--- linux-2.6/include/asm-x86_64/topology.h	13 Sep 2004 15:24:11 -0000	1.10
+++ linux-2.6/include/asm-x86_64/topology.h	15 Sep 2004 13:57:50 -0000
@@ -29,8 +29,7 @@ static inline cpumask_t __pcibus_to_cpum
 	cpus_and(res, busmask, online);
 	return res;
 }
-/* broken generic file uses #ifndef later on this */
-#define pcibus_to_cpumask(bus) __pcibus_to_cpumask(bus)
+#define pcibus_to_cpumask(bus) __pcibus_to_cpumask(bus->number)
 
 #define NODE_BALANCE_RATE 30	/* CHECKME */ 
 

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
